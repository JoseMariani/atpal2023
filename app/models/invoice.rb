class Invoice < Statement

  belongs_to :student
  belongs_to :study_period

  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates_presence_of :first_name, :message => "this field cannot be blank"
  validates_presence_of :last_name, :message => "this field cannot be blank"
  validates_presence_of :start_date, :message => "this field cannot be blank"
  validates_presence_of :end_date, :message => "this field cannot be blank"
  validates_presence_of :entire_stay_duration
  validates_presence_of :email_address
  validates_presence_of :agency_id
  validates_presence_of :adulthood_id
  validates_presence_of :accommodation_id
  validates_presence_of :region_id
  validates_presence_of :program_id
  validates_presence_of :promo_ids
  validates_presence_of :program_total
  validates_presence_of :balance
  validates_presence_of :accommodation_total
  validates_length_of :email_address, :maximum => 100
  validates_format_of :email_address, :with => EMAIL_REGEX, :message => "invalid format"

  after_create :set_student_to_registered

  def rebate_result(cost, promo_percentage)
    if cost == 390
      (390*(1-promo_percentage)).round(-1)
    else
      ((cost*(1-promo_percentage))/5).round(0)*5
    end
  end

  def next
    self.student.statements.where("id > ?", id).first
  end

  def prev
    self.student.statements.where("id < ?", id).last
  end

  def update_student_and_period
    if self.update_student?
      student.update_attr(self)
      study_period.update_attr(self)
    end

    study_period.update_balance(self)
  end

  def set_student_to_registered
    self.student.set_to_registered
  end
end
