class InsurancesController < ApplicationController

  before_action :authenticate_user!

  def index
    @insurances = Insurance.all
    authorize @insurances
  end

  def edit
    @insurance = Insurance.find(params[:id])
    authorize @insurance
  end

  def update
    @insurance = Insurance.find(params[:id])
    authorize @insurance
    if @insurance.update_attributes(insurance_params)
      flash[:success] = 'Insurance record successfully updated'
      redirect_to(insurances_path)
    else
      flash[:error] = 'Insurance record could not be updated'
      render("edit")
    end
  end

  def new
    @insurance = Insurance.new
    authorize @insurance
  end

  def create
    @insurance = Insurance.new(insurance_params)
    authorize @insurance
    if @insurance.save
      flash[:success] = 'Insurance record successfully created'
      redirect_to(insurances_path)
    else
      flash[:error] = 'Insurance record could not be created'
      render("new")
    end
  end

  def destroy
    @insurance = Insurance.find(params[:id])
    authorize @insurance
    if @insurance.destroy
      flash[:success] = 'Insurance record successfully deleted'
      redirect_to(insurances_path)
    else
      flash[:error] = 'Insurance record could not be deleted'
      render("delete")
    end
  end

  def update_insurance_cost
    @insurance = Insurance.find(params[:id])
    @billing_type = params[:billing_type]
    authorize @insurance
    respond_to do |format|
      format.js
    end
  end

  private

  def insurance_params
    params.require(:insurance).permit(:name, :cost)
  end
end
