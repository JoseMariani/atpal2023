class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.references :student, index: true, foreign_key: true
      t.boolean :graduate
      t.decimal :total_grade, precision: 5, scale: 2

      t.timestamps null: false
    end
  end
end
