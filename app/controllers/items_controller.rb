class ItemsController < ApplicationController

  before_action :authenticate_user!
  def index
  end

  def show
  end

  def new
    @item.new
  end

  def edit
  end

  def delete
  end
end
