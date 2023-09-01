class RemoveAdultColumnFromAccommodations < ActiveRecord::Migration
  def change
    remove_column :accommodations, :adult
  end
end
