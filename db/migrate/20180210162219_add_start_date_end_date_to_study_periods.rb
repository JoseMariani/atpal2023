class AddStartDateEndDateToStudyPeriods < ActiveRecord::Migration
  def change
    add_column :study_periods, :start_date_accommodation, :date
    add_column :study_periods, :end_date_accommodation, :date
  end
end
