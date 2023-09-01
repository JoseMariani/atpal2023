class CreateAutomatizations < ActiveRecord::Migration
  def change
    create_table :automatizations do |t|
      t.string :description
      t.date :date
      t.string :letter_grade
      t.references :evaluation, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
