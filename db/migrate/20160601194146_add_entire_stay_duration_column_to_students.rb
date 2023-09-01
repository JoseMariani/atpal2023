class AddEntireStayDurationColumnToStudents < ActiveRecord::Migration
  def change
    add_column :students, :entire_stay_duration, :integer
  end
end
