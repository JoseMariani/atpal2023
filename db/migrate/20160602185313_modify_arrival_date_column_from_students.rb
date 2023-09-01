class ModifyArrivalDateColumnFromStudents < ActiveRecord::Migration
  def change
    change_column :students, :arrival_date, :date
  end
end
