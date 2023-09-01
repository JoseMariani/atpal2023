class CreateSharpAndSmarts < ActiveRecord::Migration
  def change
    create_table :sharp_and_smarts do |t|
      t.string :descrption
      t.date :date
      t.string :letter_grade
      t.references :evaluation, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
