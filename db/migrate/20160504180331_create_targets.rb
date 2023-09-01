class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.references :evaluation, index: true, foreign_key: true
      t.string :description
      t.date :date
      t.string :letter_grade
      t.string :student_input

      t.timestamps null: false
    end
  end
end
