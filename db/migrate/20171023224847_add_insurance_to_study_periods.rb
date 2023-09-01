class AddInsuranceToStudyPeriods < ActiveRecord::Migration
  def change
    add_reference :study_periods, :insurance, index: true, foreign_key: true
  end
end
