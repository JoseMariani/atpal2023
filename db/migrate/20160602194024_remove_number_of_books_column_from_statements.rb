class RemoveNumberOfBooksColumnFromStatements < ActiveRecord::Migration
  def change
    remove_column :statements, :number_of_books
  end
end
