class GraduateFinishingStudent < ActiveJob::Base
  include Delayed::RecurringJob

  run_every 1.day
  run_at '6:40pm'
  timezone 'Eastern Time (US & Canada)'
  queue :default

  def perform
    ActiveRecord::Base.clear_active_connections!
    Delayed::Worker.logger.info("Graduate student job executed on #{DateTime.now}")

    Student.finished_today(Date.today).each do |student|
      student.update_attribute(:status, "Graduate") if (student.status == "Active" || student.status == "active")
      Delayed::Worker.logger.info("Graduating student: #{student.complete_name_cap}, with id: #{student.id}")
    end
  end
end
