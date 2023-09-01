class CreateFixedDurationProStudents < ActiveRecord::Migration
  def change
    create_table :fixed_duration_pro_students do |t|
      t.references :fixed_duration_program, index: true, foreign_key: true
      t.references :student, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
