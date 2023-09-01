class AddInsuranceStartDateEndDateToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :start_date_insurance, :date
    add_column :statements, :end_date_insurance, :date
  end
end
