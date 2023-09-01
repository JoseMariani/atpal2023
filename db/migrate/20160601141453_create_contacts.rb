class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :last_name
      t.string :email_address
      t.string :phone_number
      t.string :position
      t.string :branch

      t.timestamps null: false
    end
  end
end
