Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed_job.log'))
Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.max_run_time = 15.minutes

ActivateStartingStudent.schedule!
GraduateFinishingStudent.schedule!
CreateEvaluationStartingStudent.schedule!
