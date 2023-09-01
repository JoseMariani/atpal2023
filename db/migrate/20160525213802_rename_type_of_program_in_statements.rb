class RenameTypeOfProgramInStatements < ActiveRecord::Migration
  def change
    rename_column :statements, :type_of_program, :course_language
  end
end
