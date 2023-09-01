class Accommodation < ActiveRecord::Base

  before_destroy :no_referenced_statements

  validates_presence_of :type_of_accommodation
  validates_presence_of :adulthood
  validates_presence_of :cost

  has_many :study_periods
  has_many :statements, :through => :study_periods

  belongs_to :adulthood

  def no_referenced_statements
    return if statements.empty?

    errors.add(type_of_accommodation, " is referenced by statements(s): #{statements.map(&:id).to_sentence}")
    false # If you return anything else, the callback will not stop the destroy from happening
  end

  def no_referenced_students
    return if students.empty?

    errors.add(:base, "this accommodation is referenced by students(s): #{statements.map(&:id).to_sentence}")
    false # If you return anything else, the callback will not stop the destroy from happening
  end
end
