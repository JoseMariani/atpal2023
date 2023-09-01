class RemoveColumnsFromStudents < ActiveRecord::Migration
  def up
    remove_column :students, :start_date
    remove_column :students, :end_date
    remove_column :students, :duration_weeks
    remove_column :students, :week_program_hours
    remove_foreign_key :students, column: :program_id
    remove_reference :students, :program, index: true
    remove_column :students, :total_amount
    remove_column :students, :balance
    remove_column :students, :documents_sent
    remove_column :students, :arrival_date
    remove_column :students, :certificate_issued
    remove_column :students, :course_language
    remove_foreign_key :students, column: :accommodation_id
    remove_reference :students, :accommodation, index: true
    remove_column :students, :entire_stay_duration
    remove_column :students, :program_cost
    remove_column :students, :accommodation_duration
    remove_column :students, :week_program_range
    remove_column :students, :program_total
    remove_column :students, :accommodation_total
  end

  def down
    add_column :students, :start_date, :date
    add_column :students, :end_date, :date
    add_column :students, :duration_weeks, :integer
    add_column :students, :week_program_hours,:integer
    add_reference :students, :program, index: true
    add_foreign_key :students, :programs
    add_column :students, :total_amount, :string
    add_column :students, :balance, :string
    add_column :students, :documents_sent, :string
    add_column :students, :arrival_date, :date
    add_column :students, :certificate_issued, :string
    add_column :students, :course_language, :string
    add_reference :students, :accommodation, index: true
    add_foreign_key :students, :accommodations
    add_column :students, :entire_stay_duration, :integer
    add_column :students, :program_cost, :integer
    add_column :students, :accommodation_duration, :integer
    add_column :students, :week_program_range, :integer
    add_column :students, :program_total, :decimal, precision: 7, scale: 2
    add_column :students, :accommodation_total, :decimal, precision: 7, scale: 2
  end
end
