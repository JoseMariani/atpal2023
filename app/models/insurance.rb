class Insurance < ActiveRecord::Base

  has_many :study_periods
  has_many :statements

  validates_presence_of :name
  validates_numericality_of :cost
end
