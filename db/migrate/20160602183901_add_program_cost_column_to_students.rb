class AddProgramCostColumnToStudents < ActiveRecord::Migration
  def change
    add_column :students, :program_cost, :decimal, precision: 7, scale: 2
  end
end
