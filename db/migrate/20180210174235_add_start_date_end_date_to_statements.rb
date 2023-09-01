class AddStartDateEndDateToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :start_date_accommodation, :date
    add_column :statements, :end_date_accommodation, :date
  end
end
