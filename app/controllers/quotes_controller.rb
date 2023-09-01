class QuotesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_student
  
  def index
    if params[:student_id]
      @quotes = params[:study_period_id].present? ? @student.study_periods.find(params[:study_period_id]).quotes : @student.study_periods.last.quotes
    else
      if current_user.marketer?
        @quotes = Quote.allowed_quotes(current_user)
      else
        @quotes = Quote.all
      end
    end
    authorize @quotes
  end

  def show
    @quote = Quote.find(params[:id])
    respond_to do |format|
      format.html {
        @insurance = @quote.insurance || Insurance.order(:name).first
      }
      format.pdf do
        render :pdf => "quote.pdf",
               :template => "quotes/show.pdf.erb",
               :layout => "pdf_layout.html",
               :page_size => "Letter",
               margin:  {   top:               2,                     # default 10 (mm)
                            bottom:            22,
                            left:              0,
                            right:             0 },
               footer:  {:margin => { :left => 0, :right => 0 },
                         :html => {:template => 'quotes/footer.pdf.erb'}}
      end
    end
    authorize @quote
  end

  def new
    @quote = @student.study_periods.last.quotes.new(new_params)
    @insurance = @quote.insurance || Insurance.order(:name).first
    authorize @quote
  end
  
  def create
    @quote = @student.study_periods.last.quotes.new(quote_params)
    authorize @quote
    if @quote.save
      flash[:success] = 'Quote created successfully'
      redirect_to(:action => :show, student_id: @student.id, :id => @quote.id)
    else
      flash[:alert] = @quote.errors.full_messages.join(', ')
      render("new")
    end
  end

  def edit
    @quote = @student.study_periods.last.quotes.find(params[:id])
    authorize @quote
  end

  def delete
    @quote = @student.study_periods.last.quotes.find(params[:id])
    authorize @quote
  end

  def destroy
    @quote = @student.study_periods.last.quotes.find(params[:id])
    authorize @quote
    if @quote.destroy_statement
      redirect_to student_quotes_path(student_id: @student.id)
    else
      flash[:alert] = @quote.errors.full_messages.join(', ')
      render('delete')
    end
  end

  def load_config
    @quote = @student.study_periods.last.quotes.find(params[:id])
    authorize @quote
    if @quote.update_student_and_period
      flash[:notice] = 'configuration loaded'
    end
    redirect_to student_path(@quote.student_id)
  end
  
  private
  
  def quote_params
    params.require(:quote).permit(:first_name, :last_name, :nationality, :duration_weeks, :phone_number, :email_address,
      :start_date, :accommodation_id, :adulthood_id, :insurance_id, :insurance_cover_period, :insurance_cost,
      :number_of_books, :number_of_hours, :end_date, :student_id, :total, :update_student, :study_period_id,
      :start_date_insurance, :end_date_insurance, :date_of_validity, :course_language, :program_id, :week_program_hours,
      :post_rebate_program_cost, :start_date_accommodation, :end_date_accommodation, :insurance_cover_period,
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
