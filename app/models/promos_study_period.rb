class PromosStudyPeriod < ActiveRecord::Base
  belongs_to :promo
  belongs_to :study_period
end
