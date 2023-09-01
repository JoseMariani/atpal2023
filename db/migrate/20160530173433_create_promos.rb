class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.text :description
      t.decimal :number, precision: 4, scale: 2
      t.string :percentage

      t.timestamps null: false
    end
  end
end
