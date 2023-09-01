class CreateStudyPeriods < ActiveRecord::Migration
  def change
    create_table :study_periods do |t|
      t.date :start_date
      t.date :end_date
      t.integer :duration_weeks
      t.integer :week_program_hours
      t.integer :total_hours
      t.references :program, index: true, foreign_key: true
      t.string :total_amount
      t.string :balance
      t.string :documents_sent
      t.date :arrival_date
      t.string :certificate_issued
      t.string :course_language
      t.references :accommodation, index: true, foreign_key: true
      t.references :adulthood, index: true, foreign_key: true
      t.references :student, index: true, foreign_key: true
      t.integer :entire_stay_duration
      t.integer :program_cost
      t.integer :accommodation_duration
      t.integer :week_program_range
      t.decimal :program_total, precision: 7, scale: 2
      t.decimal :accommodation_total, precision: 7, scale: 2

      t.timestamps null: false
    end
  end
end
