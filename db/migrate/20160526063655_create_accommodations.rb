class CreateAccommodations < ActiveRecord::Migration
  def change
    create_table :accommodations do |t|
      t.string :adult?
      t.string :type

      t.timestamps null: false
    end
  end
end
