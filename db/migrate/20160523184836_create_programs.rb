class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :title
      t.integer :number_of_hours
      t.decimal :cost, precision: 7, scale: 2

      t.timestamps null: false
    end
  end
end
