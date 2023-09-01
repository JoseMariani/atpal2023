class AddEndDateToEvaluations < ActiveRecord::Migration
  def change
    add_column :evaluations, :end_date, :date
  end
end
