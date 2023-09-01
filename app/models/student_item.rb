class StudentItem < ActiveRecord::Base
  belongs_to :student
  belongs_to :item

  accepts_nested_attributes_for :item, reject_if: :all_blank
end
