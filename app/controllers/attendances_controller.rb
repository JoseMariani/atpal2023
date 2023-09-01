class AttendancesController < DailyController

  before_action :authenticate_user!
  before_action :find_evaluation

  def index
    if params[:evaluation_id]
      if params[:start_date].present? && params[:end_date].present?
        zone = 'Eastern Time (US & Canada)'
        start_date = ActiveSupport::TimeZone[zone].parse(params[:start_date]).utc
        end_date = ActiveSupport::TimeZone[zone].parse(params[:end_date]).end_of_day.utc
        @attendances = @evaluation.attendances.between(start_date, end_date)
        @charted_attendances = @attendances.where.not(absent: "Justified Absence")
      else
        @attendances = @evaluation.attendances.newest_first
      end
      @charted_attendances = @attendances.where.not(absent: "Justified Absence")
    else
      @attendances = Attendance.newest_first
    end
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "attendances.pdf",
               :template => "attendances/index.pdf.erb",
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
    authorize @attendances
  end
  
  def create
    @attendance = @evaluation.attendances.new(attendance_params)
    @student = @evaluation.study_period.student
    authorize @attendance
    if @attendance.save
      respond_to do |format|
        format.html {redirect_to(:controller => :students, :action => :index)}
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
    if params[:evaluation_id]
      @attendance = @evaluation.attendances.find(params[:id])
      @student = @evaluation.study_period.student
      @detail_view = 1 if params[:detail_view]
    end
    authorize @attendance
    respond_to do |format|
      format.js
    end
  end

  def update
    @attendance = @evaluation.attendances.find(params[:id])
    @student = @evaluation.study_period.student
    authorize @attendance
    if @attendance.update_attributes(attendance_params)
      respond_to do |format|
        format.html {redirect_to(:controller => :students, :action => :index)}
        format.js {
          if params[:detail_view].present?
            @attendances = @evaluation.attendances.newest_first
            @charted_attendances = @attendances.where.not(absent: "Justified Absence")
            render 'attendances/update_detail_view'
          else
            render 'attendances/update'
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

  def justify_absence
    @attendance = @evaluation.attendances.find(params[:id])
    @attendance.justify_absence
    authorize @attendance
    if @attendance.save
      @attendances = @evaluation.attendances.newest_first
      @charted_attendances = @attendances.where.not(absent: "Justified Absence")
      respond_to do |format|
        format.html {
          flash[:success] = "Absence justified successfully"
          redirect_to :back
        }
        format.js
      end
    else
      @attendances = @evaluation.attendances.newest_first
      @charted_attendances = @attendances.where.not(absent: "Justified Absence")
      respond_to do |format|
        format.html {
          flash[:error] = @attendance.errors.full_messages
          redirect_to :back
        }
        format.js {
          render 'attendances/justify_absence'
        }
      end
    end
  end
  
  private
  
  def attendance_params
    params.require(:attendance).permit(:hour, :absent, :penalty, :grade, :created_at)
  end
  
  def find_evaluation
    if params[:evaluation_id]
      @evaluation = Evaluation.find(params[:evaluation_id])
    end
  end
end
