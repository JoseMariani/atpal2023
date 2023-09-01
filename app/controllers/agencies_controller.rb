class AgenciesController < ApplicationController
  before_action :authenticate_user!

  def index
    @agencies = policy_scope(Agency)
    authorize @agencies
  end

  def show
    @agency = Agency.find(params[:id])

    unless current_user.admin?
      unless current_user.agencies.include?(@agency)
        flash[:alert] = "You are not authorized to view or modify this agency."
        redirect_to(agencies_path)
      end
    end

    authorize @agency
  end

  def new
    @agency = Agency.new
    authorize @agency
  end

  def create
    @agency = Agency.new(agency_params)
    authorize @agency
    if @agency.save
      redirect_to(agencies_path)
    else
      render('new')
    end
  end

  def edit
    @agency = Agency.find(params[:id])

    unless current_user.admin?
      unless current_user.agencies.include?(@agency)
        flash[:alert] = "You are not authorized to view or modify this agency."
        redirect_to(agencies_path)
      end
    end

    authorize @agency
  end

  def update
    @agency = Agency.find(params[:id])
    authorize @agency

    unless current_user.admin?
      unless current_user.agencies.include?(@agency)
        flash[:alert] = "You are not authorized to view or modify this agency."
        redirect_to(agencies_path)
      end
    end

    if @agency.update_attributes(agency_params)
      flash[:notice] = "Agency updated successfully."
      redirect_to(agency_path)
    else
      render('edit')
    end
  end

  def delete
    @agency = Agency.find(params[:id])

    if current_user.agencies.include?(@agency)
      flash[:alert] = "You are not authorized to view or modify this agency."
      redirect_to(agencies_path)
    end

    authorize @agency
  end

  def destroy
    @agency = Agency.find(params[:id])
    authorize @agency

    if current_user.agencies.include?(@agency)
      flash[:alert] = "You are not authorized to view or modify this agency."
      redirect_to(agencies_path)
    elsif @agency.destroy
      redirect_to(agencies_path)
    else
      render('delete')
    end

  end

  private

  def agency_params
    params.require(:agency).permit(:name, :country, :address, :phone_number, :email, :commission,
                                   contacts_attributes: [:id, :name, :last_name, :email_address, :phone_number,
                                                         :position, :branch, :_destroy], :user_ids => [])
  end
end
