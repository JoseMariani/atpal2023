class RegionsController < ApplicationController

  before_action :authenticate_user!

  def index
    @regions = Region.all.order('name DESC')
    authorize @regions
  end

  def show
    @region = Region.find(params[:id])
    authorize @region
  end

  def edit
    @region = Region.find(params[:id])
    authorize @region
  end

  def update
    @region = Region.find(params[:id])
    authorize @region
    if @region.update_attributes(region_params)
      redirect_to(region_path)
    else
      render("edit")
    end
  end

  def new
    @region = Region.new
    authorize @region
  end

  def create
    @region = Region.new(region_params)
    authorize @region
    if @region.save
      redirect_to(regions_path)
    else
      render("new")
    end
  end

  def delete
    @region = Region.find(params[:id])
    authorize @region
  end

  def destroy
    @region = Region.find(params[:id])
    authorize @region
    if @region.destroy
      redirect_to(regions_path)
    else
      render("delete")
    end
  end

  private

  def region_params
    params.require(:region).permit(:name, :promo_ids => [])
  end
end
