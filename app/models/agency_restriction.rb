class AgencyRestriction < ActiveRecord::Base
  belongs_to :user
  belongs_to :agency
end
