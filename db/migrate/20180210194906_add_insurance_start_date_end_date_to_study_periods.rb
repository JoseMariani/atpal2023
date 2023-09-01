class AddInsuranceStartDateEndDateToStudyPeriods < ActiveRecord::Migration
  def change
    add_column :study_periods, :start_date_insurance, :date
    add_column :study_periods, :end_date_insurance, :date
  end
end
