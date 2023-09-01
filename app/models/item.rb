class Item < ActiveRecord::Base
  belongs_to :statement
  has_many :student_items
  has_many :students, through: :student_items

  has_many :study_period_items
  has_many :study_periods, through: :study_period_items

  has_many :statement_items
  has_many :statements, through: :statement_items


  def combined_value
    "#{self.name} | Quantity: #{self.quantity} | Price per unit: $#{self.price_per_unit} | Total: $#{self.total}"
  end
end
