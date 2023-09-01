class AccommodationsController < ApplicationController

  before_action :authenticate_user!

  def index
    @accommodations = Accommodation.all
    authorize @accommodations
  end

  def show
    @accommodation = Accommodation.find(params[:id])
    authorize @accommodation
  end

  def new
    @accommodation = Accommodation.new
    authorize @accommodation
  end

  def create
    @accommodation = Accommodation.new(accommodation_params)
    authorize @accommodation
    if @accommodation.save
      redirect_to(accommodations_path)
    else
      render("new")
    end
  end

  def edit
    @accommodation = Accommodation.find(params[:id])
    authorize @accommodation
  end

  def update
    @accommodation = Accommodation.find(params[:id])
    authorize @accommodation
    if @accommodation.update_attributes(accommodation_params)
      redirect_to(accommodation_path(@accommodation.id))
    else
      render("edit")
    end
  end

  def delete
    @accommodation = Accommodation.find(params[:id])
    authorize @accommodation
  end

  def destroy
    @accommodation = Accommodation.find(params[:id])
    authorize @accommodation
    if @accommodation.destroy
      redirect_to(accommodations_path)
    else
      render("delete")
    end
  end

  private

  def accommodation_params
    params.require(:accommodation).permit(:adulthood_id, :type_of_accommodation, :cost)
  end
end
