class Region < ActiveRecord::Base

  validates_presence_of :name

  has_many :students
  has_and_belongs_to_many :promos

  def no_referenced_students
    return if students.empty?

    errors.add(:base, "this Region is referenced by student(s): #{students.map(&:id).to_sentence}")
    false # If you return anything else, the callback will not stop the destroy from happening
  end
end
