class ProFormasController < ApplicationController

  before_action :authenticate_user!
  before_action :find_student

  def index
    if params[:student_id]
      @pro_formas = params[:study_period_id].present? ? @student.study_periods.find(params[:study_period_id]).pro_formas : @student.study_periods.last.pro_formas
    else
      if current_user.marketer?
        @pro_formas = ProForma.allowed_proformas(current_user)
      else
        @pro_formas = ProForma.all
      end
    end
    authorize @pro_formas
  end

  def show
    @pro_forma = ProForma.find(params[:id])
    respond_to do |format|
      format.html {
        @insurance = @pro_forma.insurance || Insurance.order(:name).first
      }
      format.pdf do
        render :pdf => "pro_forma.pdf",
               :template => "pro_formas/show.pdf.erb",
               :layout => "pdf_layout.html",
               :page_size => "Letter",
               margin:  {   top:               2,                     # default 10 (mm)
                            bottom:            33,
                            left:              0,
                            right:             0 },
               footer:  {:margin => { :left => 0, :right => 0 },
                         :html => {:template => 'quotes/footer.pdf.erb'}}
      end
    end
    authorize @pro_forma
  end

  def new
    @pro_forma = @student.study_periods.last.pro_formas.new(new_params)
    @insurance = @pro_forma.insurance || Insurance.order(:name).first
    authorize @pro_forma
  end

  def create
    @pro_forma = @student.study_periods.last.pro_formas.new(pro_forma_params)
    authorize @pro_forma
    if @pro_forma.save
      flash[:success] = 'Pro forma created successfully'

      #update raoutes and links
      redirect_to(:action => :show, :id => @pro_forma.id)
    else
      flash[:alert] = @pro_forma.errors.full_messages.join(', ')
      render("new")
    end
  end

  def edit
    @pro_forma = @student.study_periods.last.pro_formas.find(params[:id])
    authorize @pro_forma
  end

  def delete
    @pro_forma = @student.study_periods.last.pro_formas.find(params[:id])
    authorize @pro_forma
  end

  def load_config
    @pro_forma = @student.study_periods.last.pro_formas.find(params[:id])
    authorize @pro_forma
    if update_student_and_period
      flash[:notice] = 'configuration loaded'
    end
    redirect_to student_path(@pro_forma.student_id)
  end

  private

  def pro_forma_params
    params.require(:pro_forma).permit(:first_name, :last_name, :nationality, :duration_weeks, :phone_number,
      :email_address, :start_date, :accommodation_id, :adulthood_id, :insurance_id, :insurance_cover_period,
      :insurance_cost, :number_of_books, :number_of_hours, :end_date, :student_id, :total, :update_student,
      :start_date_accommodation, :end_date_accommodation, :start_date_insurance, :end_date_insurance, :insurance_cover_period,
      :study_period_id, :date_of_validity, :course_language, :program_id, :week_program_hours, :post_rebate_program_cost,
      :program_cost, :total_amount, :accommodation_cost, :program_total, :accommodation_duration, :week_program_range,
      :raw_program_cost, :accommodation_total, :region_id, :entire_stay_duration, :agency_id, :promo_ids => [],
      :fixed_duration_pro_statements_attributes => [:id, :fixed_duration_program_id, :statement_id, :_destroy],
      :statement_items_attributes => [:id, :item_id, :statement_id, :_destroy, item_attributes: [:id, :name, :quantity,
      :price_per_unit, :total, :_destroy]])
  end

  def find_student
    if params[:student_id]
      @student = Student.find(params[:student_id])
    end
  end

  def new_params
    Statement.new_params(@student)
  end

end
