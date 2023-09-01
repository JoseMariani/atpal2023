class AddNewColumnsToSns < ActiveRecord::Migration
  def change
    add_column :sharp_and_smarts, :score, :integer
    add_column :sharp_and_smarts, :color, :string
  end
end
