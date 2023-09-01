class AddWeekProgramHoursColumnToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :week_program_hours, :integer
  end
end
