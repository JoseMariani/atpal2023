class AddUpdateStudentBooleanToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :update_student, :boolean
  end
end
