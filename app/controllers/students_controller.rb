class StudentsController < ApplicationController

  before_action :authenticate_user!

  def index
    authorize self
  end

  def show
    @student = Student.find(params[:id])
    @notes = @student.notes

    if current_user.marketer?
      unless Student.allowed_students(current_user).include?(@student)
        flash[:alert] = "You are not authorized to view or modify this student."
        redirect_to(students_path)
      end
    end

    authorize @student
  end

  def new
    @student = Student.new
    @levels = Student.levels
    authorize @student
  end

  def create
    @student = Student.new(student_params)
    @levels = Student.levels
    authorize @student
    if @student.save
      if params[:student][:status].downcase == 'active'
        @student.activate_student
      end
      flash[:success] = 'Student successfully created'
      redirect_to student_path(@student)
    else
      flash[:error] = 'Something went wrong, please check that all necessary fields are filled'
      render("new")
    end
  end

  def edit
    @student = Student.find(params[:id])
    @levels = Student.levels

    if current_user.marketer?
      unless Student.allowed_students(current_user).include?(@student)
        flash[:alert] = "You are not authorized to view or modify this student."
        redirect_to(students_path)
      end
    end
    authorize @student
  end

  def update
    @student = Student.find(params[:id])
    @levels = Student.levels

    if current_user.marketer?
      unless Student.allowed_students(current_user).include?(@student)
        flash[:alert] = "You are not authorized to view or modify this student."
        redirect_to(students_path)
      end
    end

    authorize @student
    if @student.update_attributes(student_params)
      if params[:student][:status].downcase == 'active'
        @student.activate_student
      end
      flash[:success] = 'Student successfully updated'
      redirect_to(@student)
    else
      flash[:error] = 'Something went wrong'
      render('edit')
    end
  end

  def activate
    @student = Student.find(params[:id])
    authorize @student
    @student.activate_student
    flash[:success] = 'Student set to active'
    redirect_to(@student)
  end

  def deactivate
    @student = Student.find(params[:id])
    authorize @student
    @student.deactivate_student
    flash[:success] = 'Student set to Status not determined'
    redirect_to(@student)
  end

  def delete
    @student = Student.find(params[:id])
    authorize @student
  end

  def destroy
    @student = Student.find(params[:id])
    authorize @student
    @student.destroy
    flash[:success] = 'Student(s) successfully deleted'
    redirect_to(:action => :index)
  end

  def import
    if Student.import(params[:file])
      redirect_to students_path, notice: "file imported."
    else
      redirect_to students_path, alert: "error occurred with the file."
    end
  end

  def edit_multiple
    @students = Student.all
    @data = {levels: Student.levels, groups: Student.groups}
    authorize(@students || @student)
    if params[:student_ids]
      @students = Student.find(params[:student_ids])
    else
      flash[:error] = 'You must choose a student before trying to update'
      redirect_to active_students_path
    end
  end

  def update_multiple
    @students = Student.all
    authorize @students
    result = Student.update(params[:students].keys, params[:students].values)
    errors = []
    result.each do |res|
      errors << "student with id #{res.id} returned the following error: #{res.errors.full_messages.join(",")}" if res.errors.present?
    end
    if errors.any?
      flash[:error] = errors
    else
      flash[:success] = 'Student(s) successfully updated'
    end
    redirect_to active_students_path
  end

  def active
    @students = Student.where(status: 'Active')
    authorize @students
  end

  def student_list

    search_string = []

    (study_period_columns + student_columns + program_columns + region_columns + agency_columns + accommodation_columns).each do |term|
      search_string << "#{term} like :search"
    end

    students = sort_table
    students = students.paginate(:page => page, :per_page => per_page)
    @students = students.table_search.where(search_string.join(' or '), search: "%#{params[:search][:value]}%").uniq { |s| s.id }

    @data = {
        draw: params[:draw],
        start: params[:start],
        length: params[:length],
        search_value: params[:search][:value],
        search_regex: params[:search][:regex],
        column_number_order: params[:order]["0"][:column].to_i,
        direction_order: params[:order]["0"][:dir],
        column_data: params[:columns]["0"][:data],
        column_searchable: params[:columns]["0"][:searchable],
        column_orderable: params[:columns]["0"][:orderable],
        column_search_value: params[:columns]["0"][:search][:value],
        column_search_regex: params[:columns]["0"][:search][:regex],
        total_records: @students.count,
        records_filtered: @students.total_entries
    }
    authorize self
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name, :date_of_birth, :nationality, :gender, :age, :phone_number,
      :email_address, :passport_number, :adulthood_id, :emergency_contact, :residential_address, :address_in_canada,
      :insurance, :caq, :air_ticket, :visa, :airport_transfer, :study_permit, :student_phone_number, :emergency_email,
      :region_id, :agency_id, :image, :status, :level, :passport_picture, :certificate_picture, :remove_image,
      :proficiency_level, :complete_name, :remove_passport_picture, :remove_certificate_picture, :itinerary,
      :remove_itinerary)
  end

  def page
    params[:start].to_i / per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_table
    if current_user.marketer?
      students = Student.allowed_students(current_user)
    else
      students = Student
    end
    students.table_search.order("#{sort_column} #{order_criteria}")
  end

  def sort_column
    if program_columns.any? { |s| s.include?(filter_sort_column) }
      'programs.title'
    elsif region_columns.any? { |s| s.include?(filter_sort_column) }
      'regions.name'
    elsif agency_columns.any? { |s| s.include?(filter_sort_column) }
      'agencies.name'
    elsif accommodation_columns.any? { |s| s.include?(filter_sort_column) }
      'accommodations.type_of_accommodation'
    elsif study_period_columns.any? { |s| s.include?(filter_sort_column) }
      "study_periods.#{filter_sort_column}"
    else
      "students.#{filter_sort_column}"
    end
  end

  def order_criteria
    params[:order]["0"][:dir] == 'asc' ? 'asc' : 'desc'
  end

  def student_columns
    %w(students.first_name students.last_name students.email_address students.nationality students.passport_number
      students.date_of_birth students.insurance students.residential_address students.emergency_email
      students.address_in_canada students.caq students.airport_transfer students.visa
      students.air_ticket students.email_address students.gender students.age students.phone_number students.total_hours
      students.status students.student_id)
  end

  def study_period_columns
    %w(study_periods.start_date study_periods.end_date study_periods.course_language study_periods.duration_weeks
      study_periods.total_amount study_periods.balance study_periods.arrival_date study_periods.certificate_issued
      study_periods.total_hours)
  end

  def program_columns
    %w(programs.title)
  end

  def region_columns
    %w(regions.name)
  end

  def agency_columns
    %w(agencies.name)
  end

  def accommodation_columns
    %w(accommodations.type_of_accommodation)
  end

  private

  def filter_sort_column
     if params[:columns][params[:order]["0"][:column]][:data] == 'agency'
       'agencies'
     else
       params[:columns][params[:order]["0"][:column]][:data]
     end
  end

end
