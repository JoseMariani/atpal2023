class SpecialActivitiesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_evaluation
  
  def index
    if params[:evaluation_id]
      @special_activities = @evaluation.special_activities.newest_first
    else
      @special_activities = SpecialActivity.newest_first
    end
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "special_activities.pdf",
               :template => "special_activities/index.pdf.erb",
               :layout => "pdf_layout.html",
               :page_size => "Letter",
               :orientation => 'Landscape',
               :javascript_delay => 3000,
               margin:  {   top:               5,                     # default 10 (mm)
                            bottom:            5,
                            left:              10,
                            right:             10 }
      end
    end
    authorize @special_activities
  end

  def show
    if params[:evaluation_id]
      @special_activity = @evaluation.special_activities.find(:id)
    else
      @special_activity = SpecialActivity.find(params[:id])
    end
    authorize @special_activity
  end

  def new
    if params[:evaluation_id]
      @special_activity = @evaluation.special_activities.new(special_activity_params)
    else
      @special_activity = SpecialActivity.new(special_activity_params)
    end
    authorize @special_activity
  end
  
  def create
    if params[:evaluation_id]
      @special_activity = @evaluation.special_activities.new(special_activity_params)
    else
      @special_activity = SpecialActivity.new(special_activity_params)
    end
    authorize @special_activity
    if @special_activity.save
      respond_to do |format|
        format.html {redirect_to(:controller => :students, :action => :index)}
        format.js 
      end
    end
  end

  def edit
    if params[:evaluation_id]
      @special_activity = @evaluation.special_activities.find(params[:id])
    else
      @special_activity = SpecialActivity.find(params[:id])
    end
    authorize @special_activity
    respond_to do |format|
        format.js 
    end
  end
  
  def update
    if params[:evaluation_id]
      @special_activity = @evaluation.special_activities.find(params[:id])
    else
      @special_activity = SpecialActivity.find(params[:id])
    end
    authorize @special_activity
    if @special_activity.update_attributes(special_activity_params)
      respond_to do |format|
        format.html {redirect_to(:controller => :students, :action => :index)}
        format.js 
      end
    end
  end
  

  def delete
    if params[:evaluation_id]
      @special_activity = @evaluation.special_activities.find(:id)
    else
      @special_activity = SpecialActivity.find(params[:id])
    end
    authorize @special_activity
  end
  
  def destroy
    if params[:evaluation_id]
      @special_activity = @evaluation.special_activities.find(:id)
    else
      @special_activity = SpecialActivity.find(params[:id])
    end
    authorize @special_activity
    if @special_activity.destroy
      redirect_to(:controller => :students, :action => :index)
    end
  end
  
  private
  
  def special_activity_params
    params.require(:special_activity).permit(:description, :date, :research_grade, 
      :presentation_grade, :written_grade, :letter_grade)
  end
  
  def find_evaluation
    if params[:evaluation_id]
      @evaluation = Evaluation.find(params[:evaluation_id])
    end
  end
end
