class FixedDurationProStudent < ActiveRecord::Base
  belongs_to :fixed_duration_program
  belongs_to :student

  accepts_nested_attributes_for :fixed_duration_program, :reject_if => :all_blank
end
