class Adulthood < ActiveRecord::Base
  has_many :accommodations
  has_many :students

  has_many :study_periods

  has_many :statements, through: :students
end
