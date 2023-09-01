class CreateStudyPeriodFixedPrograms < ActiveRecord::Migration
  def change
    create_table :study_period_fixed_programs do |t|
      t.references :study_period, index: true, foreign_key: true
      t.references :fixed_duration_program, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
