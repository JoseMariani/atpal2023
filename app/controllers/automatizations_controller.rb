class AutomatizationsController < DailyController

  before_action :authenticate_user!
  before_action :find_evaluation

  def index
    if params[:evaluation_id]
      if params[:start_date].present? && params[:end_date].present?
        zone = 'Eastern Time (US & Canada)'
        start_date = ActiveSupport::TimeZone[zone].parse(params[:start_date]).utc
        end_date = ActiveSupport::TimeZone[zone].parse(params[:end_date]).end_of_day.utc
        @automatizations = @evaluation.automatizations.between(start_date, end_date)
      else
        @automatizations = @evaluation.automatizations.newest_first
      end
      @charted_automatizations = @automatizations
    else
      @automatizations = Automatization.newest_first
    end
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "automatizations.pdf",
               :template => "automatizations/index.pdf.erb",
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
    authorize @automatizations
  end

  def create
    if params[:evaluation_id]
      @automatization = @evaluation.automatizations.new(automatization_params)
      @student = @evaluation.study_period.student
    else
      @automatization = Automatization.new(automatization_params)
    end
    authorize @automatization
    if @automatization.save
      respond_to do |format|
        format.html {redirect_to(:controller => :students, :action => :index)}
        format.js
      end
    else
      respond_to do |format|
        format.html {
          flash[:alert] = "something went wrong"
          redirect_to(:controller => :students, :action => :index)
        }
        format.js {
          render 'automatizations/create'
        }
      end
    end
  end

  def edit
    if params[:evaluation_id]
      @automatization = @evaluation.automatizations.find(params[:id])
      @student = @evaluation.study_period.student
      @detail_view = 1 if params[:detail_view]
    end
    authorize @automatization
    respond_to do |format|
      format.js
    end
  end

  def update
    @automatization = @evaluation.automatizations.find(params[:id])
    @student = @evaluation.study_period.student
    authorize @automatization
    if @automatization.update_attributes(automatization_params)
      respond_to do |format|
        format.html {redirect_to(:controller => :students, :action => :index)}
        format.js {
          if params[:detail_view].present?
            @automatizations = @evaluation.automatizations.newest_first
            @charted_automatizations = @automatizations
            render 'automatizations/update_detail_view'
          else
            render 'automatizations/update'
          end
        }
      end
    end
  end

  def batch_edit
    @students = batch_edit_current_active_student_query
    @list_data = {language: params[:language], group: params[:group]}
    authorize @students
  end

  private

  def automatization_params
    params.require(:automatization).permit(:description, :date, :letter_grade)
  end

  def find_evaluation
    if params[:evaluation_id]
      @evaluation = Evaluation.find(params[:evaluation_id])
    end
  end
end
