class StockLedgersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ledger, only: [:edit, :update]

  def index
    @stock_ledgers = StockLedger.includes(:metal, :purity, :jewellery_category)
                                .order(created_at: :desc)
  end

  def new
    @stock_ledger = StockLedger.new
    load_metal_dependencies
  end

  def edit
    @stock_ledger = current_user.stock_ledgers.find(params[:id])
    load_metal_dependencies
  end

  def create
    @stock_ledger = current_user.stock_ledgers.new(ledger_params)
    if @stock_ledger.save
      redirect_to stock_ledgers_path, notice: "Stock entry saved."
    else
      render :new
    end
  end

  def update
    if @stock_ledger.update(ledger_params)
      redirect_to stock_ledgers_path, notice: "Stock entry updated."
    else
      render :edit
    end
  end

  private

  def set_ledger
    @stock_ledger = StockLedger.find(params[:id])
  end

  def ledger_params
    params.require(:stock_ledger).permit(:metal_id, :purity_id, :jewellery_category_id, :transaction_type, :weight, :unit, :rate, :notes, :referenceable_type, :referenceable_id)
  end

  def load_metal_dependencies
    # grouped hashes for JS
    @purities_by_metal = Purity.active.group_by(&:metal_id).transform_values { |p| p.map { |x| {id: x.id, name: x.name} } }
    @categories_by_metal = JewelleryCategory.active.group_by(&:metal_id).transform_values { |c| c.map { |x| {id: x.id, name: x.name} } }
  end
end