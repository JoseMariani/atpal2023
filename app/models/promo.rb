class Promo < ActiveRecord::Base

  validates_presence_of :description
  validates_presence_of :type_of_promo

  has_and_belongs_to_many :regions
  has_and_belongs_to_many :students
  has_and_belongs_to_many :statements
  has_and_belongs_to_many :fixed_duration_programs
  has_and_belongs_to_many :study_periods

  before_save :assign_number

  def no_referenced_regions
    return if regions.empty?

    errors.add(:base, "this Promotion is referenced by student(s): #{regions.map(&:id).to_sentence}")
    false # If you return anything else, the callback will not stop the destroy from happening
  end

  def no_referenced_students
    return if students.empty?

    errors.add(:base, "this Promotion is referenced by student(s): #{students.map(&:id).to_sentence}")
    false # If you return anything else, the callback will not stop the destroy from happening
  end

  def no_referenced_statements
    return if statements.empty?

    errors.add(:base, "this Promotion is referenced by student(s): #{statements.map(&:id).to_sentence}")
    false # If you return anything else, the callback will not stop the destroy from happening
  end

  private

  def assign_number
    self.number = (percentage.to_f/100).round(2)
  end
end
