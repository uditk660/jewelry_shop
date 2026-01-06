class MetalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_metal, only: [:edit, :update]

  def index
    @metals = Metal.order(:name)
  end

  def new
    @metal = Metal.new
  end

  def create
    @metal = Metal.new(metal_params)
    if @metal.save
      redirect_to metals_path, notice: "Metal created successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @metal.update(metal_params)
      redirect_to metals_path, notice: "Metal updated successfully"
    else
      render :edit
    end
  end

  private

  def set_metal
    @metal = Metal.find(params[:id])
  end

  def metal_params
    params.require(:metal).permit(:name, :base_unit, :active)
  end
end
