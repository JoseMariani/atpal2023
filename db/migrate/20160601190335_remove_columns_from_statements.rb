class RemoveColumnsFromStatements < ActiveRecord::Migration
  def change
    remove_column :statements, :date_of_birth
    remove_column :statements, :gender
    remove_column :statements, :age
    remove_column :statements, :custodianship_letter
    remove_column :statements, :airport_pickup
  end
end
