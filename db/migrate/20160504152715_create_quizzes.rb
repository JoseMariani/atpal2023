class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.references :evaluation, index: true, foreign_key: true
      t.date :date
      t.string :level
      t.string :letter_grade
      t.decimal :grade_percentage, precision: 5, scale: 2

      t.timestamps null: false
    end
  end
end
