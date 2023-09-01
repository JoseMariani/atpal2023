class AddReferencesToTables < ActiveRecord::Migration
  def change
    add_reference :accommodations, :adulthood, index: true, foreign_key: true
    add_reference :students, :adulthood, index: true, foreign_key: true
    add_reference :statements, :adulthood, index: true, foreign_key: true
  end
end
