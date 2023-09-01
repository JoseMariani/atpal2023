class RenameAdultColumnInAccommodations < ActiveRecord::Migration
  def change
    rename_column :accommodations, :adult?, :adult
  end
end
