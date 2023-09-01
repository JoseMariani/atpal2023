class CreateEvaluationStartingStudent < ActiveJob::Base
  include Delayed::RecurringJob

  run_every 1.day
  run_at '6:50pm'
  timezone 'Eastern Time (US & Canada)'
  queue :default

  def perform
    ActiveRecord::Base.clear_active_connections!
    Delayed::Worker.logger.info("Create evaluation job executed on #{DateTime.now}")

    Student.start_tomorrow(Date.today).each do |student|
      if student.study_periods.any? && student.study_periods.last.evaluations.empty? && student.status.downcase == "active"
        student.study_periods.last.evaluations.create(language: student.study_periods.last.course_language, end_date: student.study_periods.last.end_date, is_active: true)
        Delayed::Worker.logger.info("Creating evaluation for student: #{student.complete_name_cap}, with id: #{student.id}")
      end
    end
  end
end
