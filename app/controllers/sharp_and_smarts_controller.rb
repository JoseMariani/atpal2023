class SharpAndSmartsController < DailyController

  before_action :authenticate_user!
  before_action :find_evaluation

  def index
    if params[:evaluation_id]
      if params[:start_date].present? && params[:end_date].present?
        zone = 'Eastern Time (US & Canada)'
        start_date = ActiveSupport::TimeZone[zone].parse(params[:start_date]).utc
        end_date = ActiveSupport::TimeZone[zone].parse(params[:end_date]).end_of_day.utc
        @sns = @evaluation.sharp_and_smarts.between(start_date, end_date)
      else
        @sns = @evaluation.sharp_and_smarts.newest_first
      end
      @charted_sns = @sns
    else
      @sns = SharpAndSmart.newest_first
    end
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "special_activities.pdf",
               template: "sharp_and_smarts/index.pdf.erb",
               layout: "pdf_layout.html",
               page_size: "Letter",
               orientation: 'Landscape',
               javascript_delay: 3000,
               margin: {
                 top: 5, # default 10 (mm)
                 bottom: 5,
                 left: 10,
                 right: 10
               }
      end
    end
    authorize @sns
  end

  def create
    if params[:evaluation_id]
      @sharp = @evaluation.sharp_and_smarts.new(sns_params)
      @student = @evaluation.study_period.student
    else
      @sharp = SharpAndSmart.new(sns_params)
    end
    authorize @sharp
    if @sharp.save
      respond_to do |format|
        format.html {redirect_to(controller: :students, action: :index)}
        format.js
      end
    else
      respond_to do |format|
        format.html {
          flash[:alert] = "something went wrong"
          redirect_to(controller: :students, action: :index)
        }
        format.js
      end
    end
  end

  def edit
    if params[:evaluation_id]
      @sharp = @evaluation.sharp_and_smarts.find(params[:id])
      @student = @evaluation.study_period.student
      @detail_view = 1 if params[:detail_view]
    end
    authorize @sharp
    respond_to do |format|
      format.js
    end
  end

  def update
    @sharp = @evaluation.sharp_and_smarts.find(params[:id])
    @student = @evaluation.study_period.student
    authorize @sharp
    if @sharp.update_attributes(sns_params)
      respond_to do |format|
        format.html {redirect_to(controller: :students, action: :index)}
        format.js {
          if params[:detail_view].present?
            @sharps = @evaluation.sharp_and_smarts.newest_first
            @charted_sns = @sharps
            render 'sharp_and_smarts/update_detail_view'
          else
            render 'sharp_and_smarts/update'
          end
        }
      end
    end
  end

  def batch_edit
    @students = batch_edit_current_active_student_query
    @sns = SharpAndSmart.new
    @list_data = {language: params[:language], group: params[:group]}
    authorize @students
  end

  private

  def sns_params
    params.require(:sharp_and_smart).permit(:description, :date, :letter_grade, :score, :color)
  end

  def find_evaluation
    if params[:evaluation_id]
      @evaluation = Evaluation.find(params[:evaluation_id])
    end
  end
end
