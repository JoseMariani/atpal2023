class Payment < ActiveRecord::Base
  belongs_to :student
  belongs_to :statement

  belongs_to :study_period
end
