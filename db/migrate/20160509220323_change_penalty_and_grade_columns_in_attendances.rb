class ChangePenaltyAndGradeColumnsInAttendances < ActiveRecord::Migration
  def change
    change_column :attendances, :grade, :decimal, precision: 5, scale: 2
    change_column :attendances, :penalty, :decimal, precision: 5, scale: 2
  end
end
