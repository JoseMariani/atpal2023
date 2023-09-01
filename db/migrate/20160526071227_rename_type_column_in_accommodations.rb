class RenameTypeColumnInAccommodations < ActiveRecord::Migration
  def change
    rename_column :accommodations, :type, :type_of_accommodation
  end
end
