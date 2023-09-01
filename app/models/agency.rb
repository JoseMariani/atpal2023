class Agency < ActiveRecord::Base

  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  VALID_PHONE_NUMBER_REGEX = /([0-9\s\-]{7,})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?\z/

  before_destroy :no_referenced_students
  before_destroy :no_referenced_statements

  validates_presence_of :name
  validates_length_of :email, :maximum => 100
  validates_format_of :email, :with => EMAIL_REGEX, :message => "invalid email format"

  has_many :contacts, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :statements, dependent: :destroy
  has_many :agency_restrictions
  has_many :users, :through => :agency_restrictions
  accepts_nested_attributes_for :contacts, reject_if: :all_blank, allow_destroy: true

  def no_referenced_students
    return if students.empty?

    errors.add(:base, self.name + " is referenced by student(s): #{students.map(&:id).to_sentence}")
    false # If you return anything else, the callback will not stop the destroy from happening
  end

  def no_referenced_statements
    return if statements.empty?

    errors.add(:base, " is referenced by student(s): #{statements.map(&:id).to_sentence}")
    false # If you return anything else, the callback will not stop the destroy from happening
  end

end
