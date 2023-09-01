class AddStatusAndPreviousColumnsToStatementsAndStudents < ActiveRecord::Migration
  def change
    add_column :statements, :previous_balance, :boolean
    add_column :students, :status, :string
  end
end
