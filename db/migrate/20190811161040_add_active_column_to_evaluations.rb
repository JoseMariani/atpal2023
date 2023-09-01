class AddActiveColumnToEvaluations < ActiveRecord::Migration
  def up
    unless column_exists? :evaluations, :is_active
      add_column :evaluations, :is_active, :boolean, default: false
    end

    Student.all.each do |student|
      next if student.study_periods.empty?
      next if student.study_periods.last.evaluations.empty?

      student.study_periods.last.evaluations.last.update(is_active: true)
    end
  end

  def down
    remove_column :evaluations, :is_active
  end
end
