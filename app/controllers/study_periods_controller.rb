class StudyPeriodsController < ApplicationController

  before_action :authenticate_user!

  def new
    @student = Student.find(params[:student_id])
    @study_period = @student.study_periods.new
    authorize(@study_period)
  end

  def create
    @student = Student.find(params[:student_id])
    @study_period = @student.study_periods.create(study_period_params)
    authorize(@study_period)
    flash[:success] = "Study period successfully created"
    redirect_to student_path(@student.id)
  end

  def index
    @student = Student.find(params[:student_id])
    @study_periods = @student.study_periods
    authorize(@study_periods)
  end

  def show
    @student = Student.find(params[:student_id])
    @study_period = @student.study_periods.find(params[:id])
    authorize(@study_period)
  end

  def letter_of_acceptance
    @student = Student.find(params[:student_id])
    @study_period = @student.study_periods.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "letter_of_acceptance.pdf",
               :template => "study_periods/letter_of_acceptance.pdf.erb",
               :layout => "pdf_layout.html",
               :page_size => "Letter",
               margin:  {   top:               2,                     # default 10 (mm)
                            bottom:            22,
                            left:              0,
                            right:             0 },
               footer:  {:margin => { :left => 0, :right => 0 },
                         :html => {:template => "quotes/footer.pdf.erb"}}
      end
    end
    authorize(@study_period)
  end

  def edit
    @student = Student.find(params[:student_id])
    @study_period = @student.study_periods.find(params[:id])
    authorize(@study_period)
  end

  def update
    @student = Student.find(params[:student_id])
    @study_period = @student.study_periods.find(params[:id])
    authorize(@study_period)
    if @study_period.update_attributes(study_period_params)
      flash[:success] = "Student successfully updated"
      redirect_to(@student)
    else
      flash[:error] = "The study period could not be saved"
      render("edit")
    end
  end

  def delete
    @student = Student.find(params[:student_id])
    @study_period = @student.study_periods.find(params[:id])
    authorize(@study_period)
  end

  def destroy
    @student = Student.find(params[:student_id])
    @study_period = @student.study_periods.find(params[:id])
    authorize @study_period
    if @study_period.has_associations
      flash[:error] = "Study has existing associations"
    else
      @study_period.destroy
      flash[:success] = "Study period successfully deleted"
    end

    redirect_to student_study_periods_path(student_id: @student.id)
  end

  private

  def study_period_params
    params.require(:study_period).permit(:start_date, :end_date, :duration_weeks, :insurance_id, :certificate_picture,
     :accommodation_id, :program_id, :adulthood_id, :course_language, :student_id, :accommodation_total,
     :remove_certificate_picture, :week_program_hours, :total_hours, :program_cost, :total_amount, :balance,
     :program_total, :start_date_accommodation, :end_date_accommodation, :start_date_insurance, :end_date_insurance, :insurance_cover_period,
     :arrival_date, :certificate_issued, :entire_stay_duration, :accommodation_duration, :week_program_range,
     :study_period_fixed_programs_attributes => [:id, :study_period_id, :fixed_duration_program_id, :_destroy],
     :study_period_items_attributes => [:id, :item_id, :study_period_id, :_destroy, item_attributes: [:id, :name, :quantity, :price_per_unit, :total, :_destroy]])
  end
end
