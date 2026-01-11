class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def index
    @companies = Company.order(created_at: :desc)
  end

  def show
  end

  def new
    @company = Company.new
  end

  def edit
  end

  def create
    @company = Company.new(company_params)
    if @company.save!
      redirect_to @company, notice: "Company created successfully"
    else
      render :new
    end
  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: "Company updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @company.destroy
    redirect_to companies_path, notice: "Company deleted"
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(
      :name, :address, :city, :pin,
      :phone, :email, :gst, :adhaar, :pan,
      :logo
    )
  end
end
