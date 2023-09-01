class AddAccommodationTotalToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :accommodation_total, :decimal, precision: 7, scale: 2
  end
end
