class PublicController < ApplicationController

  before_action :authenticate_user!, except: :index
  after_action :verify_authorized, except: :index, unless: :devise_controller?

  def index

  end

  def language
    authorize self
  end

  def group
    authorize self
    @language = params[:language]
  end

  def type
    authorize self
    @language = params[:language]
    @group = params[:group]
  end

end
