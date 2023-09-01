class ChangeNumberOfHoursFromStudent < ActiveRecord::Migration
  def change
    rename_column :students, :number_of_hours, :week_program_hours
    add_column :students, :total_hours, :integer
  end
end
