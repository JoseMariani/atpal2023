class AddCompleteNameColumnToStudents < ActiveRecord::Migration
  def change
    add_column :students, :complete_name, :string
  end
end
