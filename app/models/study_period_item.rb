class StudyPeriodItem < ActiveRecord::Base
  belongs_to :study_period
  belongs_to :item
end
