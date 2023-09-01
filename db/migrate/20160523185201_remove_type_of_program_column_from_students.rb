class RemoveTypeOfProgramColumnFromStudents < ActiveRecord::Migration
  def change
    remove_column :students, :type_of_program
  end
end
