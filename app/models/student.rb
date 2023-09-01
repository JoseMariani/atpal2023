class Student < ActiveRecord::Base

  enum level: [:unknown, :int_1, :int_2, :int_3, :adv_1, :adv_2, :beginner]
  enum group: [:no_group, :intermediate_a, :intermediate_b, :intermediate_c, :intermediate_d, :intermediate_e,
               :intermediate_f, :advanced_a, :advanced_b, :advanced_c, :beginner_a, :beginner_b]

  mount_uploader :image, ImageUploader
  mount_uploader :passport_picture, PassportPictureUploader
  mount_uploader :certificate_picture, CertificatePictureUploader
  mount_uploader :itinerary, ItineraryUploader

  has_many :study_periods, dependent: :destroy
  has_many :statements, dependent: :destroy
  has_many :quotes, dependent: :destroy
  has_many :pro_formas, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :student_items, :dependent => :destroy
  has_many :items, through: :student_items
  has_many :payments, dependent: :destroy
  has_many :evaluations, dependent: :destroy
  has_many :fixed_duration_pro_students, :dependent => :destroy
  has_many :fixed_duration_programs, :through => :fixed_duration_pro_students
  belongs_to :adulthood
  belongs_to :region
  belongs_to :agency
  has_and_belongs_to_many :promos
  has_many :notes, dependent: :destroy

  accepts_nested_attributes_for :notes, :reject_if => :all_blank, allow_destroy: true
  accepts_nested_attributes_for :promos, :reject_if => :all_blank, allow_destroy: true
  accepts_nested_attributes_for :fixed_duration_programs, :reject_if => :all_blank, allow_destroy: true
  accepts_nested_attributes_for :fixed_duration_pro_students, :reject_if => :all_blank, allow_destroy: true
  accepts_nested_attributes_for :items, :reject_if => :all_blank, allow_destroy: true
  accepts_nested_attributes_for :student_items, :reject_if => :all_blank, allow_destroy: true

  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  VALID_PHONE_NUMBER_REGEX = /([0-9\s\-]{7,})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?\z/

  validates_presence_of :first_name, :alert => "this field cannot be blank"
  validates_presence_of :last_name, :message => "this field cannot be blank"
  validates_uniqueness_of :student_id, :message => "student already registered or id already taken", :allow_blank => true, :allow_nil => true

  after_save :assign_id

  scope :last_name_asc, lambda { order("students.last_name ASC" ) }
  scope :last_name_desc, lambda { order("students.last_name DESC" )}
  scope :newest_first, lambda { order("students.created_at DESC" )}
  scope :end_date_desc, lambda { order("students.end_date DESC" )}
  scope :end_date_asc, lambda { order("students.end_date ASC" )}
  scope :start_date_desc, lambda { order("students.start_date DESC" )}
  scope :start_date_asc, lambda { order("students.start_date ASC" )}
  scope :last_modified, lambda { order("students.updated_at DESC" )}
  scope :search, lambda {|query| where(['first_name LIKE ? OR last_name LIKE ? OR nationality LIKE ?',
      "%#{query}%", "%#{query}%", "%#{query}%"])}
  scope :start_next_week, -> (start_date) { joins(:study_periods).merge(StudyPeriod.where("study_periods.start_date >= ? AND study_periods.start_date <= ?", start_date, start_date + 5.days))}
  scope :start_tomorrow, -> (start_date) { joins(:study_periods).merge(StudyPeriod.where("study_periods.start_date > ? AND study_periods.start_date <= ?", start_date, start_date + 1.days))}


  scope :finish_this_week, -> (end_date) { joins(:study_periods).merge(StudyPeriod.where("study_periods.end_date >= ? AND study_periods.end_date <= ?", end_date, end_date + 2.days)) }
  scope :finished_today, -> (end_date) { joins(:study_periods).merge(StudyPeriod.where("study_periods.end_date = ?", end_date)) }

  scope :by_agency, -> (agency) {where(agency: agency)}

  scope :table_search, -> {joins("LEFT JOIN study_periods ON students.id = study_periods.student_id")
                               .where("study_periods.created_at = (SELECT MAX(study_periods.created_at) FROM study_periods WHERE study_periods.student_id = students.id)")
                               .joins("LEFT JOIN `regions` ON regions.id = students.region_id")
                               .joins("LEFT JOIN `agencies` ON agencies.id = students.agency_id")
                               .joins("LEFT JOIN `accommodations` ON accommodations.id = study_periods.accommodation_id")
                               .joins("LEFT JOIN `programs` ON programs.id = study_periods.program_id")}

  def has_evaluation?
    self.study_periods.any? && self.study_periods.last.evaluations.count > 0
  end

  def update_attr(ogi)
    attr = ogi.attributes.slice(*self.attribute_names).except("id","student_id")
    self.update_attributes(attr)
  end

  def update_balance(ogi)
    self.update_attributes(:balance => ogi.balance)
  end

  def check_student_id
      if !self.student_id.nil? && Student.where(:student_id => self.student_id).exists?
        errors.add(:student_id, " repeated")
      end
  end

  def activate_student
    unless self.status == 'Active' || self.status == 'active' || self.status == 'Graduate' || self.status == 'graduate'
      self.update_attribute(:status, 'Active')
    end
  end

  def set_to_registered
    unless self.status == 'Active' || self.status == 'active' || self.status == 'Graduate' || self.status == 'graduate' || self.status == 'Registered' || self.status == 'registered'
      self.update_attribute(:status, 'Registered')
    end
  end

  def assign_id
    if self.student_id.blank? && (self.status == 'Active' || self.status == 'active' || self.status == 'Graduate' || self.status == 'graduate' || self.status == 'Registered' || self.status == 'registered')

      id = 901241
      until Student.find_by_student_id(id).nil?
        id += 1
      end
      self.update_attribute(:student_id, id)
    end
  end

  def deactivate_student
    unless self.status == 'Status not determined' || self.status == 'status not determined'
      self.update_attribute(:status, 'Status not determined')
      self.update_attribute(:student_id, nil)
    end
  end

  def first_name_last_name
    self.first_name.downcase + ' ' + self.last_name.downcase
  end

  def complete_name_cap
    self.first_name.split.map(&:capitalize).join(' ') + ' ' + self.last_name.split.map(&:capitalize).join(' ')
  end

  def self.import(file)
    if file.nil?
      return false
    else
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |variable|
        row = Hash[[header, spreadsheet.row(variable)].transpose]
        student = find_by_id(row["id"]) || new
        student.attributes =  row.to_hash
        complete_name = row['first_name'].downcase + ' ' + row['last_name'].downcase
        status = row['status']
        if status.casecmp('graduate') || status.casecmp('active')
          id = '90'+ (Student.where(:status => 'graduate').count + Student.where(:status => 'active').count).to_s
          until Student.find_by_student_id(id).nil?
            id = '90'+ (Student.where(:status => 'graduate').count + Student.where(:status => 'active').count + 1).to_s
          end
          student.assign_attributes(student_id: id)
        end
        student.assign_attributes(complete_name: complete_name)
        if student.save

        else
          next
        end
      end
      AssignGenderJob.perform_now
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path, nil, :ignore)
      when ".xls" then Roo::Excelx.new(file.path)
      when ".xlsx" then Roo::Excelx.new(file.path)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def update_evaluations
    self.study_periods.last.evaluations.each do |eval|
      eval.old!
    end
    self.study_periods.last.evaluations.last.current!
  end

  def get_age
    unless self.date_of_birth.nil?
      (Time.now.to_s(:number).to_i - self.date_of_birth.to_time.to_s(:number).to_i)/10e9.to_i
    end
  end

  def latest_study_period
    return if self.study_periods.empty?

    self.study_periods.last
  end

  def not_evaluable
    self.study_periods.empty? or self.study_periods.last.evaluations.empty?
  end

  # TODO: Change to active eval
  def latest_program_title
    self.study_periods.last.try(:program).try(:title)
  end

  def region_name
    self.region.try(:name)
  end

  def agency_name
    self.agency.try(:name)
  end

  # TODO: Change to active eval
  def latest_accommodation_title
    return "" if self.study_periods.empty? or self.study_periods.last.accommodation.nil?
    self.study_periods.last.try(:accommodation).try(:type_of_accommodation)
  end

  # TODO: Change to active eval
  def already_started_study_period?
    return if self.study_periods.empty? or self.study_periods.last.start_date.nil?
    self.study_periods.last.start_date < Date.today
  end

  def current_study_period_with_active_eval
    current_study_period = nil
    self.study_periods.each do |sp|
      sp.evaluations.each do |eval|
        current_study_period = sp if eval.is_active?
      end
    end

    current_study_period
  end

  def default_evaluation
    return if self.study_periods.empty? or current_study_period_with_active_eval.nil?

    default_evaluation = nil
    current_study_period_with_active_eval.evaluations.each do |eval|
      default_evaluation = eval if eval.is_active?
    end

    default_evaluation
  end

  def starting_future_study_period?
    return if self.study_periods.empty? or current_study_period_with_active_eval.nil?

    default_evaluation.present? && current_study_period_with_active_eval.start_date > 1.day.ago
  end

  # study period with active evaluation methods
  #
  #

  def study_period_with_active_eval_start_date
    return "" if current_study_period_with_active_eval.blank?
    current_study_period_with_active_eval.start_date
  end

  def study_period_with_active_eval_end_date
    return "" if self.study_periods.empty? or current_study_period_with_active_eval.nil? or current_study_period_with_active_eval.end_date.nil?
    current_study_period_with_active_eval.end_date
  end

  def study_period_with_active_eval_course_language
    return "" if self.study_periods.empty? or current_study_period_with_active_eval.nil? or current_study_period_with_active_eval.course_language.nil?
    current_study_period_with_active_eval.course_language
  end

  def study_period_with_active_eval_duration_weeks
    return "" if self.study_periods.empty? or current_study_period_with_active_eval.nil? or current_study_period_with_active_eval.duration_weeks.nil?
    current_study_period_with_active_eval.duration_weeks
  end

  def latest_evaluation
    return if self.study_periods.empty? or current_study_period_with_active_eval.duration_weeks.nil?

    default_evaluation
  end

  def latest_attendance
    return if self.study_periods.empty? or current_study_period_with_active_eval.blank? or default_evaluation.attendances.empty?

    default_evaluation.attendances.last
  end

  def latest_target
    return if self.study_periods.empty? or current_study_period_with_active_eval.blank? or default_evaluation.targets.empty?

    default_evaluation.targets.last
  end

  def latest_sns
    return if self.study_periods.empty? or current_study_period_with_active_eval.blank? or default_evaluation.sharp_and_smarts.empty?

    default_evaluation.sharp_and_smarts.last
  end

  def latest_automatization
    return if self.study_periods.empty? or current_study_period_with_active_eval.blank? or default_evaluation.automatizations.empty?

    default_evaluation.automatizations.last
  end

  # latest study period methods
  #
  #

  def study_period_start_date
    return "" if self.study_periods.empty? or self.study_periods.last.start_date.nil?
    self.study_periods.last.start_date
  end

  def study_period_end_date
    return "" if self.study_periods.empty? or self.study_periods.last.end_date.nil?
    self.study_periods.last.end_date
  end

  def study_period_course_language
    return "" if self.study_periods.empty? or self.study_periods.last.course_language.nil?
    self.study_periods.last.course_language
  end

  def study_period_duration_weeks
    return "" if self.study_periods.empty? or self.study_periods.last.duration_weeks.nil?
    self.study_periods.last.duration_weeks
  end

  def study_period_total_amount
    return "" if self.study_periods.empty? or self.study_periods.last.total_amount.nil?
    self.study_periods.last.total_amount
  end

  def study_period_balance
    return "" if self.study_periods.empty? or self.study_periods.last.balance.nil?
    self.study_periods.last.balance
  end

  def study_period_arrival_date
    return "" if self.study_periods.empty? or self.study_periods.last.arrival_date.nil?
    self.study_periods.last.arrival_date
  end

  def study_period_certificate_issued
    return "" if self.study_periods.empty? or self.study_periods.last.certificate_issued.nil?
    self.study_periods.last.certificate_issued
  end

  def study_period_total_hours
    return "" if self.study_periods.empty? or self.study_periods.last.total_hours.nil?
    self.study_periods.last.total_hours
  end

  def most_current_study_period
    if self.study_periods.size > 1
      intensive_study_periods = self.study_periods.joins(:program).where('lower(programs.title) = ?', 'intensive training'.downcase)
      if intensive_study_periods.any?
        intensive_study_periods.where('start_date <= ? AND end_date >= ?', Date.today, Date.today).sort_by { |sp| sp.end_date }.last || intensive_study_periods.last
      else
        self.study_periods.where('start_date <= ? AND end_date >= ?', Date.today, Date.today).sort_by { |sp| sp.end_date }.last || self.study_periods.sort_by { |sp| sp.end_date }.last
      end
    else
      self.study_periods.last
    end
  end

  def most_current_program
    self.most_current_study_period.try(:program)
  end

  def most_current_accommodation
    self.most_current_study_period.try(:accommodation)
  end

  def most_current_start_date
    if self.study_periods.size > 1
      tentative_date = self.study_periods.where('start_date <= ? AND end_date >= ?', Date.today, Date.today).sort_by { |sp| sp.start_date }.last.try(:start_date)
      tentative_date.present? ? tentative_date : self.study_periods.sort_by { |sp| sp.start_date }.last.try(:start_date)
    else
      self.study_periods.last.try(:start_date)
    end
  end

  def most_current_end_date
    if self.study_periods.size > 1
      tentative_date = self.study_periods.where('start_date <= ? AND end_date >= ?', Date.today, Date.today).sort_by { |sp| sp.end_date }.last.try(:end_date)
      tentative_date.present? ? tentative_date : self.study_periods.sort_by { |sp| sp.end_date }.last.try(:end_date)
    else
      self.study_periods.last.try(:end_date)
    end
  end

  def self.allowed_students(user)
    Student.where(agency: user.agencies)
  end

  def complete_name
    "#{first_name} #{last_name}"
  end
end
