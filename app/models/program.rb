class Program < ActiveRecord::Base

  validates_presence_of :title

  has_many :study_periods
  has_many :hours, dependent: :destroy
  has_many :statements, :through => :students
  has_many :weeks, dependent: :destroy
  accepts_nested_attributes_for :weeks, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :hours, reject_if: :all_blank, allow_destroy: true

  def no_referenced_students
    return if students.empty?

    errors.add(:base, "this program is referenced by student(s): #{students.map(&:id).to_sentence}")
    false # If you return anything else, the callback will not stop the destroy from happening
  end

  def title_and_cost
    self.title + ' | ' + self.cost
  end

end
