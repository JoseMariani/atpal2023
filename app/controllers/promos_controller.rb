class PromosController < ApplicationController

  before_action :authenticate_user!

  def index
    @promos = Promo.all
    authorize @promos
  end

  def show
    @promo = Promo.find(params[:id])
    authorize @promo
  end

  def edit
    @promo = Promo.find(params[:id])
    authorize @promo
  end

  def update
    @promo = Promo.find(params[:id])
    authorize @promo
    if @promo.update_attributes(promo_params)
      redirect_to(promos_path)
    else
      render("edit")
    end
  end

  def new
    @promo = Promo.new
    authorize @promo
  end

  def create
    @promo = Promo.new(promo_params)
    authorize @promo
    if @promo.save
      redirect_to(promo_path(@promo.id))
    else
      render("new")
    end
  end

  def delete
    @promo = Promo.find(params[:id])
    authorize @promo
  end

  def destroy
    @promo = Promo.find(params[:id])
    authorize @promo
    if @promo.destroy
      redirect_to(promos_path)
    else
      render("delete")
    end
  end

  private

  def promo_params
    params.require(:promo).permit(:description, :number, :percentage, :type_of_promo, :valid_until)
  end
end
