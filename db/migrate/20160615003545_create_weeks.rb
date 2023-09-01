class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.string :number
      t.decimal :cost, precision: 7, scale: 2
      t.references :program, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
