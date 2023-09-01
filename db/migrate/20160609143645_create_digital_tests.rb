class CreateDigitalTests < ActiveRecord::Migration
  def change
    create_table :digital_tests do |t|
      t.string :level
      t.string :image
      t.references :evaluation, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
