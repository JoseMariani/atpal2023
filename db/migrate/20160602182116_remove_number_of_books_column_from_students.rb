class RemoveNumberOfBooksColumnFromStudents < ActiveRecord::Migration
  def change
    remove_column :students, :number_of_books
  end
end
