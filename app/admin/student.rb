ActiveAdmin.register Student do

controller do
	include ActionView::Helpers::NumberHelper
	def scoped_collection
    super.includes :agency, study_periods: [:program, :accommodation]  # prevents N+1 queries to your database
  end
  
 before_filter :authorize_index, only: :index
 def authorize_index
   authorize :admin, :index?
 end

 before_filter :authorize_show_edit_destroy, only: [:show, :edit, :destroy]
 def authorize_show_edit_destroy
   authorize resource
 end
end	

index do
	#id_column
	column 'Internal Id' do |student|
    student.student_id
  end
 column 'First name', sortable: 'students.first_name' do |student|
 	student.first_name
 end
 column 'Last name', sortable: 'students.last_name' do |student|
 	student.last_name
 end
 column 'Nationality', sortable: 'students.nationality' do |student|
 	student.nationality
 end
 column 'Status', sortable: 'students.status' do |student|
 	student.status
 end
 column 'Level', sortable: 'students.level' do |student|
 	student.level.humanize
 end
 column 'Agency', sortable: 'agencies.name' do |student|
 	student.agency.present? ? student.agency.name : 'No agency'
 end
 column 'Group', sortable: 'students.group' do |student|
 	student.group.humanize
 end
 column 'Start date', sortable: 'study_periods.start_date' do |student|
   student.most_current_start_date
 end
 column 'End date', sortable: 'study_periods.end_date' do |student|
   student.most_current_end_date
 end
 column 'Registered at', sortable: 'students.created_at' do |student|
   student.created_at
 end
 column 'Program', sortable: 'programs.title' do |student|
   student.most_current_program.try(:title)
 end
 column 'Accommodation', sortable: 'accommodations.type_of_accommodation' do |student|
   student.most_current_accommodation.try(:type_of_accommodation)
 end
 column 'Accommodaion start date', sortable: 'study_periods.start_date_accommodation' do |student|
   student.most_current_study_period.try(:start_date_accommodation)
 end
 column 'Accommodation end date', sortable: 'study_periods.end_date_accommodation' do |student|
   student.most_current_study_period.try(:end_date_accommodation)
 end
 column 'Insurance start date', sortable: 'study_periods.start_date_insurance' do |student|
   student.most_current_study_period.try(:start_date_insurance)
 end
 column 'Insurance end date', sortable: 'study_periods.end_date_insurance' do |student|
   student.most_current_study_period.try(:end_date_insurance)
 end
  durations = []
 column 'Duration', sortable: 'study_periods.duration_weeks' do |student|
   durations << student.most_current_study_period.try(:duration_weeks)
   student.most_current_study_period.try(:duration_weeks)
 end
 column 'Airport tranfer', sortable: 'students.airport_transfer' do |student|
   student.try(:airport_transfer)
 end

  div class: "panel" do
    h3 "Total duration in weeks shown in the table: #{durations .compact.sum}"
  end
end

filter :first_name
filter :last_name
filter :agency_name, as: :select, input_html: {multiple: true}, collection: Agency.order(:name).all.map(&:name)
filter :agency_country, as: :select, input_html: {multiple: true}, collection: Agency.all.map(&:country).uniq.sort
filter :nationality
filter :group, as: :select, collection: Student.groups.map{ |group| [ group[0].humanize, group[1] ] }
filter :level, as: :select, collection: Student.levels.map{ |level| [ level[0].humanize, level[1] ] }
filter :status, as: :select
filter :created_at, label: 'Registration date'
filter :study_periods_start_date, label: 'Start date', as: :date_range
filter :study_periods_end_date, label: 'End date', as: :date_range
filter :study_periods_program_title, label: 'Program', as: :string
filter :study_periods_accommodation_type_of_accommodation, label: 'Accommodation', as: :string
filter :study_periods_start_date_accommodation, label: 'Accommodation start date', as: :date_range
filter :study_periods_start_date_insurance, label: 'Insurance start date', as: :date_range
filter :study_periods_end_date_insurance, label: 'Insurance end date', as: :date_range
filter :study_periods_duration_weeks, label: 'Duration', as: :numeric_range_filter
filter :airport_transfer, label: 'Airport transfer', as: :select
#filter :ST, label: 'End date', collection: StudyPeriod.where('end_date IS NOT NULL').map{ |sp| sp = sp.student.most_current_study_period }.sort_by{ |sp| sp.end_date }.last.end_date, as: :date_range
#filter :st, label: 'End date', collection: Student.joins("RIGHT JOIN study_periods ON students.id = study_periods.student_id").where("study_periods.end_date = (SELECT MAX(study_periods.end_date) FROM study_periods WHERE study_periods.student_id = students.id)"), as: :date_range
#filter :study_periods_start_date_lteq, label: 'Start date', as: :datepicker

csv do
  column ('Internal id')    { |student| student.student_id }
  column :first_name
  column :last_name
  column :nationality
  column :status
  column :level
  column (:agency)                    { |student| student.agency.try(:name) }
  column (:group)                     { |student| student.group.humanize }
  column (:start_date)                { |student| student.most_current_start_date }
  column (:end_date)                  { |student| student.most_current_end_date }
  column ('Registered at')            { |student| student.created_at }
  column (:program)                   { |student| student.most_current_program.try(:title) }
  column (:accommodation)             { |student| student.most_current_accommodation.try(:type_of_accommodation) }
  column ('Accommodation start date') { |student| student.most_current_study_period.try(:start_date_accommodation) }
  column ('Accommodation end date')   { |student| student.most_current_study_period.try(:end_date_accommodation) }
  column ('Insurance start date')     { |student| student.most_current_study_period.try(:start_date_insurance) }
  column ('Insurance end date')       { |student| student.most_current_study_period.try(:end_date_insurance) }
  column ('Airport transfer')       { |student| student.try(:airport_transfer) }
  column ('Duration in weeks')       { |student| student.most_current_study_period.try(:duration_weeks) }
end


end
