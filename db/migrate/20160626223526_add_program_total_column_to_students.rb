class AddProgramTotalColumnToStudents < ActiveRecord::Migration
  def change
    add_column :students, :program_total, :decimal, precision: 7, scale: 2
  end
end
