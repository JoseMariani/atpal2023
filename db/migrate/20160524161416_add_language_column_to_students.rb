class AddLanguageColumnToStudents < ActiveRecord::Migration
  def change
    add_column :students, :course_language, :string
  end
end
