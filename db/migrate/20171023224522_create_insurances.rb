class CreateInsurances < ActiveRecord::Migration
  def change
    create_table :insurances do |t|
      t.text :name
      t.decimal :cost, precision: 7, scale: 2

      t.timestamps null: false
    end
  end
end
