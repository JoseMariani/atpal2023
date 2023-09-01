class CreatePlacementFees < ActiveRecord::Migration
  def change
    create_table :placement_fees do |t|
      t.integer :quantity
      t.decimal :price_per_unit, precision: 7, scale: 2
      t.decimal :total, precision: 8, scale: 2
      t.references :item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
