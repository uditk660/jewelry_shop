class PuritiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_purity, only: [:edit, :update]

  def index
    @purities = Purity.includes(:metal).order(:name)
  end

  def new
    @purity = Purity.new
  end

  def create
    @purity = Purity.new(purity_params)
    if @purity.save
      redirect_to purities_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @purity.update(purity_params)
      redirect_to purities_path
    else
      render :edit
    end
  end

  private

  def set_purity
    @purity = Purity.find(params[:id])
  end

  def purity_params
    params.require(:purity).permit(:metal_id, :name, :purity_percent, :updated_price, :remarks, :active)
  end
end
