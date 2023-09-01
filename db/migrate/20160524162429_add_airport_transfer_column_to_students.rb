class AddAirportTransferColumnToStudents < ActiveRecord::Migration
  def change
    add_column :students, :airport_transfer, :string
  end
end
