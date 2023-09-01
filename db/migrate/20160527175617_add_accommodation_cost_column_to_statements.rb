class AddAccommodationCostColumnToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :accommodation_cost, :decimal, precision: 7, scale: 2
  end
end
