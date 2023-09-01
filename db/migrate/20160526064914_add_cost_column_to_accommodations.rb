class AddCostColumnToAccommodations < ActiveRecord::Migration
  def change
    add_column :accommodations, :cost, :decimal, precision: 7, scale: 2
  end
end
