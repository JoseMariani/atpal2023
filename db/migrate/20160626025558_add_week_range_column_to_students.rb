class AddWeekRangeColumnToStudents < ActiveRecord::Migration
  def change
    add_column :students, :week_program_range, :integer
    add_column :statements, :week_program_range, :integer
    add_column :statements, :raw_program_cost, :integer
    change_column :students, :program_cost, :integer
  end
end
