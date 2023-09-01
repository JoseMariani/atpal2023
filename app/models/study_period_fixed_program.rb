class StudyPeriodFixedProgram < ActiveRecord::Base
  belongs_to :study_period
  belongs_to :fixed_duration_program

  accepts_nested_attributes_for :fixed_duration_program, :reject_if => :all_blank
end
