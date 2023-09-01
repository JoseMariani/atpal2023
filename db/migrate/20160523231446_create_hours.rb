class CreateHours < ActiveRecord::Migration
  def change
    create_table :hours do |t|
      t.integer :number
      t.references :program

      t.timestamps null: false
    end
  end
end
