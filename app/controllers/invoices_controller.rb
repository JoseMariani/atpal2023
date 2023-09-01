class InvoicesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_student

  def index
    if params[:student_id]
      @invoices = params[:study_period_id].present? ? @student.study_periods.find(params[:study_period_id]).invoices : @student.study_periods.last.invoices
    else
      @invoices = Invoice.all
    end
    authorize @invoices
  end

  def show
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
      format.html {
        @insurance = @invoice.insurance || Insurance.order(:name).first
      }
      format.pdf do
        render :pdf => "invoice.pdf",
               :template => "invoices/show.pdf.erb",
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
    authorize @invoice
  end

  def new
    @invoice = @student.study_periods.last.invoices.new(new_params)
    @insurance = @invoice.insurance || Insurance.order(:name).first
    authorize @invoice
  end

  def create
    @invoice = @student.study_periods.last.invoices.new(invoice_params)
    authorize @invoice
    if @invoice.save
      flash[:success] = 'Invoice created successfully'
      redirect_to(:action => :show, :id => @invoice.id)
    else
      flash[:alert] = @invoice.errors.full_messages.join(', ')
      render("new")
    end
  end

  def edit
    @invoice = @student.study_periods.last.invoices.find(params[:id])
    authorize @invoice
  end

  def delete
    @invoice = @student.study_periods.last.invoices.find(params[:id])
    authorize @invoice
  end

  def destroy
    @invoice = @student.study_periods.last.invoices.find(params[:id])
    authorize @invoice
    if @invoice.destroy_statement
      redirect_to invoices_path
    else
      flash[:alert] = @invoice.errors.full_messages.join(', ')
      render('delete')
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:first_name, :last_name, :nationality, :duration_weeks, :phone_number,
      :start_date_accommodation, :end_date_accommodation, :start_date_insurance, :end_date_insurance, :insurance_cover_period,
      :email_address, :start_date, :accommodation_id, :adulthood_id, :insurance_id, :insurance_cover_period,
      :insurance_cost, :number_of_books, :number_of_hours, :end_date, :student_id, :total, :update_student,
      :study_period_id, :date_of_validity, :course_language, :program_id, :week_program_hours, :post_rebate_program_cost,
      :program_cost, :total_amount, :accommodation_cost, :program_total, :accommodation_duration, :week_program_range,
      :raw_program_cost, :accommodation_total, :region_id, :entire_stay_duration, :agency_id, :balance,
      :previous_balance, :show_payments, :show_balance, :show_bank_info, :promo_ids => [],
      :statement_items_attributes => [:id, :item_id, :statement_id, :_destroy, item_attributes: [:id, :name, :quantity,
      :price_per_unit, :total, :_destroy]], payments_attributes: [:id, :date, :amount, :student_id, :study_period_id,
      :_destroy], :fixed_duration_pro_statements_attributes => [:id, :fixed_duration_program_id, :statement_id,
      :_destroy])
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
