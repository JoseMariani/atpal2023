class AddInsuranceCostColumnToStudyPeriods < ActiveRecord::Migration
  def change
    add_column :study_periods, :insurance_cost, :decimal, precision: 7, scale: 2
  end
end
