class AddStudyPeriodToStatements < ActiveRecord::Migration
  def change
    add_reference :statements, :study_period, index: true, foreign_key: true
    add_reference :payments, :study_period, index: true, foreign_key: true
    add_reference :evaluations, :study_period, index: true, foreign_key: true
  end
end
