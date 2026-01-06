class JewelleryCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:edit, :update]

  def index
    @jewellery_categories = JewelleryCategory.includes(:metal)
  end

  def new
    @jewellery_category = JewelleryCategory.new
  end

  def create
    @jewellery_category = JewelleryCategory.new(category_params)
    if @jewellery_category.save
      redirect_to jewellery_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @jewellery_category.update(category_params)
      redirect_to jewellery_categories_path
    else
      render :edit
    end
  end

  private

  def set_category
    @jewellery_category = JewelleryCategory.find(params[:id])
  end

  def category_params
    params.require(:jewellery_category).permit(:name, :metal_id, :active)
  end
end
