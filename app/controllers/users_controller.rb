class UsersController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
    authorize @user
    if @user.save
      redirect_to users_path
    else
      render('new')
    end
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if user_params[:password].blank? || user_params[:password_confirmation].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end
    @user.update_attributes(user_params)
    if @user.save
      redirect_to users_path
    else
      render('edit')
    end
  end

  def delete
    @user = User.find(params[:id])
    authorize @user
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user
    if @user.destroy
      redirect_to users_path
    else
      render('delete')
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :password,
                                 :password_confirmation, :email, :role, :agency_ids => [])
  end
end
