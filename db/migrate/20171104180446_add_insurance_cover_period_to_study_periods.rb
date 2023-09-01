class AddInsuranceCoverPeriodToStudyPeriods < ActiveRecord::Migration
  def change
    add_column :study_periods, :insurance_cover_period, :integer
  end
end
