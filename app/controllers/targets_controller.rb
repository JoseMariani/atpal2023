class TargetsController < DailyController

  before_action :authenticate_user!
  before_action :find_evaluation

  def index
    if params[:evaluation_id]
      if params[:start_date].present? && params[:end_date].present?
        zone = 'Eastern Time (US & Canada)'
        start_date = ActiveSupport::TimeZone[zone].parse(params[:start_date]).utc
        end_date = ActiveSupport::TimeZone[zone].parse(params[:end_date]).end_of_day.utc
        @targets = @evaluation.targets.between(start_date, end_date)
      else
        @targets = @evaluation.targets.newest_first
      end
      @charted_targets = @targets
    else
      @targets = Target.newest_first
    end
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "targets.pdf",
               :template => "targets/index.pdf.erb",
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
    authorize @targets
  end

  def create
    if params[:evaluation_id]
      @target = @evaluation.targets.new(target_params)
      @student = @evaluation.study_period.student
    else
      @target = Target.new(test_params)
    end
    authorize @target
    if @target.save
      respond_to do |format|
        format.html {redirect_to(:controller => :students, :action => :index)}
        format.js
      end
    else
      respond_to do |format|
        format.js {
          render 'targets/create'
        }
      end
    end
  end

  def edit
    @target = @evaluation.targets.find(params[:id])
    @student = @evaluation.study_period.student
    @detail_view = 1 if params[:detail_view]
    authorize @target
    respond_to do |format|
        format.js
    end
  end

  def update
    @target = @evaluation.targets.find(params[:target_id])
    @student = @evaluation.study_period.student
    authorize @target
    if @target.update_attributes(target_params)
      respond_to do |format|
        format.html {redirect_to(:controller => :students, :action => :index)}
        format.js {
          if params[:detail_view].present?
            @targets = @evaluation.targets.newest_first
            @charted_targets = @evaluation.targets.newest_first
            render 'targets/update_detail_view'
          else
            render 'targets/update'
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

  def target_params
    params.require(:target).permit(:description, :date, :letter_grade, :student_input)
  end

  def find_evaluation
    if params[:evaluation_id]
      @evaluation = Evaluation.find(params[:evaluation_id])
    end
  end
end
