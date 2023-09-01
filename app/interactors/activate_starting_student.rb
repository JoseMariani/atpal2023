class ActivateStartingStudent < ActiveJob::Base
  include Delayed::RecurringJob

  run_every 1.day
  run_at '6:30pm'
  timezone 'Eastern Time (US & Canada)'
  queue :default

  def perform
    ActiveRecord::Base.clear_active_connections!
    Delayed::Worker.logger.info("Activate student job executed on #{DateTime.now}")

    Student.start_tomorrow(Date.today).each do |student|
      if (student.status.downcase == "registered")
        Delayed::Worker.logger.info("Activating student: #{student.complete_name_cap}, with id: #{student.id} from #{student.status.downcase}")
        student.update_attribute(:status, "Active")
        Delayed::Worker.logger.info("Student: #{student.complete_name_cap}, with id: #{student.id} is now #{student.status.downcase}")
      end
    end
  end

end
