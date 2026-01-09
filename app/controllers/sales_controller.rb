class SalesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sale, only: [:show]

  def index
    @sales = current_user.sales.order(sale_date: :desc)

    if params[:query].present?
      @sales = @sales.where("id LIKE ? OR total_amount LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end

    if params[:from].present? && params[:to].present?
      @sales = @sales.where(sale_date: params[:from]..params[:to])
    end

    @total_sales_amount = @sales.sum(:total_amount)
    @total_bills = @sales.count
  end

  ############### NEW ###############
  def new
     @sale = current_user.sales.new(sale_date: Date.current)
    @sale.sale_items.build

    stock = StockLedger.available.includes(:metal, :purity, :jewellery_category)

    # ----------------------------
    # METALS (only if stock exists)
    # ----------------------------
    @available_metals = Metal.where(id: stock.select(:metal_id).distinct)

    # --------------------------------
    # PURITIES (grouped by metal)
    # --------------------------------
    @purities_by_metal = {}

    stock.each do |row|
      @purities_by_metal[row.metal_id] ||= []
      @purities_by_metal[row.metal_id] << {
        id: row.purity.id,
        name: row.purity.name
      }
    end

    @purities_by_metal.each_value(&:uniq!)

    # ---------------------------------------------------
    # CATEGORIES (grouped by metal → purity)
    # ---------------------------------------------------
    @categories_by_metal_and_purity = {}

    stock.each do |row|
      metal_id  = row.metal_id
      purity_id = row.purity_id

      @categories_by_metal_and_purity[metal_id] ||= {}
      @categories_by_metal_and_purity[metal_id][purity_id] ||= []

      @categories_by_metal_and_purity[metal_id][purity_id] << {
        id: row.jewellery_category.id,
        name: row.jewellery_category.name
      }
    end

    @categories_by_metal_and_purity.each do |_, purity_hash|
      purity_hash.each_value(&:uniq!)
    end
  end


  ############### Create ###############
  def create
    @sale = current_user.sales.new(sale_params)
    item = @sale.sale_items.first

    stock = StockLedger.available.where(metal_id: item.metal_id, purity_id: item.purity_id, jewellery_category_id: item.jewellery_category_id).order(:created_at).first

    unless stock
      item.errors.add(:base, "No stock available for selected Metal / Purity / Category")
      load_sale_form_data
      render :new and return
    end
    
    item.weight = stock.weight
    price = stock.weight * stock.purity.updated_price.to_d 

    making_type  = params.dig(:sale, :sale_items_attributes, "0", :making_type)
    making_value = params.dig(:sale, :sale_items_attributes, "0", :making_value).to_d 

    item.rate = if making_type == "percentage"
                  price + (price * making_value / 100)
                else
                  price + making_value
                end
    if @sale.save
      stock.update!( unit: stock.unit - 1 )
      redirect_to @sale, notice: "Sale completed successfully."
    else
      render :new
    end
  end

  def show
  end

  private

  def set_sale
    @sale = current_user.sales.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(
      :sale_date,
      sale_items_attributes: [
        :id,
        :metal_id,
        :purity_id,
        :jewellery_category_id,
        :weight,
        :rate,
        :making_type,
        :making_value,
        :_destroy
      ]
    )
  end

  def load_sale_form_data
    stock = StockLedger.available
    @available_metals = Metal.where(id: stock.select(:metal_id).distinct)

    @purities_by_metal =
      stock.includes(:purity)
           .group_by(&:metal_id)
           .transform_values do |rows|
             rows.map(&:purity).uniq.map { |p| { id: p.id, name: p.name } }
           end

    @categories_by_metal_and_purity =
      stock.includes(:jewellery_category)
           .group_by { |s| [s.metal_id, s.purity_id] }
           .each_with_object({}) do |((metal_id, purity_id), rows), hash|
             hash[metal_id] ||= {}
             hash[metal_id][purity_id] =
               rows.map(&:jewellery_category).uniq.map { |c| { id: c.id, name: c.name } }
           end
  end
end