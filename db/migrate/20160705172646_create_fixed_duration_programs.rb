class CreateFixedDurationPrograms < ActiveRecord::Migration
  def change
    create_table :fixed_duration_programs do |t|
      t.string :name
      t.integer :duration_weeks
      t.decimal :cost, precision: 7, scale: 2

      t.timestamps null: false
    end
  end
end
