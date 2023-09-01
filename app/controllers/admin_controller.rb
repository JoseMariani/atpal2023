class AdminController < ApplicationController

  before_action :authenticate_user!
  after_action :verify_authorized, :except => ["pdf"], unless: :devise_controller?

  def index
    authorize :admin, :index?
  end

  def academic
    authorize :admin, :academic?
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "academic.pdf",
               :template => "admin/academic.pdf.erb",
               :layout => "pdf_layout.html",
               :page_size => "Letter"
      end
    end
  end
end
