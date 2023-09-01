class CreateAgencies < ActiveRecord::Migration
  def change
    create_table :agencies do |t|
      t.string :name
      t.string :country
      t.string :address
      t.string :phone_number
      t.string :email
      t.decimal :commission, precision: 7, scale: 2

      t.timestamps null: false
    end
  end
end
