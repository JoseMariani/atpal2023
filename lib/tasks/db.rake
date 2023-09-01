namespace :db do

  desc 'Pull production db to development'
  task :pull => [:dump, :restore]
  task :pull_secondary => [:dump, :restore_prod]
  task :pull_digital_ocean => [:dump_digital_ocean, :restore]
  task :pull_backup_to_main => [:dump_digital_ocean, :restore_main_server]

  task :dump do
    dumpfile = "#{Rails.root}/tmp/latest.dump"
    production = Rails.application.config.database_configuration['production']
    puts 'mysqldump on production database...'
    system "ssh deploy@198.211.115.195 'mysqldump -u #{production['username']} --password='Cotufito1' -h #{production['host']} --add-drop-table --skip-lock-tables --verbose #{production['database']}' > #{dumpfile}"
    puts 'Done!'
  end

  task :dump_digital_ocean do
    dumpfile = "#{Rails.root}/tmp/latest.dump"
    production = Rails.application.config.database_configuration['production']
    puts 'mysqldump on production database...'
    system "ssh deploy@165.227.65.1 'mysqldump -u #{production['username']} --password='28191103' -h #{production['host']} --add-drop-table --skip-lock-tables --verbose #{production['database']}' > #{dumpfile}"
    puts 'Done!'
  end

  task :restore do
    dev = Rails.application.config.database_configuration['development']
    abort 'Live db is not mysql' unless dev['adapter'] =~ /mysql/
    abort 'Missing live db config' if dev.blank?
    dumpfile = "#{Rails.root}/tmp/latest.dump"
    puts 'importing production database to development database...'
    system "mysql -h #{dev['host']} -u root #{dev['database']} --password=#{dev['password']} < #{dumpfile}"
    puts 'Done!'
  end

  task :restore_prod do
    dev = Rails.application.config.database_configuration['production']
    abort 'Live db is not mysql' unless dev['adapter'] =~ /mysql/
    abort 'Missing live db config' if dev.blank?
    dumpfile = "#{Rails.root}/tmp/latest.dump"
    puts 'importing backup production database to development database...'
    system "mysql -h #{dev['host']} -u root --password='28191103' #{dev['database']} < #{dumpfile}"
    puts 'Done!'
  end

  task :restore_main_server do
    production = Rails.application.config.database_configuration['production']
    abort 'Live db is not mysql' unless production['adapter'] =~ /mysql/
    abort 'Missing live db config' if production.blank?
    dumpfile = "#{Rails.root}/tmp/latest.dump"
    puts 'importing backup production database to production database...'
    system "mysql -h #{production['host']} -u root --password='Cotufito1' #{production['database']} < #{dumpfile}"
    puts 'Done!'
  end

  task :update_study_periods => :environment do
    Student.all.each do |student|
      StudyPeriod.create! start_date: student.start_date,
                          end_date: student.end_date,
                          duration_weeks: student.duration_weeks,
                          week_program_hours: student.week_program_hours,
                          total_hours: student.total_hours,
                          program_id: student.program_id,
                          total_amount: student.total_amount,
                          balance: student.balance,
                          documents_sent: student.documents_sent,
                          arrival_date: student.arrival_date,
                          certificate_issued: student.certificate_issued,
                          course_language: student.course_language,
                          accommodation_id: student.accommodation_id,
                          adulthood_id: student.adulthood_id,
                          student_id: student.id,
                          entire_stay_duration: student.entire_stay_duration,
                          program_cost: student.program_cost,
                          accommodation_duration: student.accommodation_duration,
                          week_program_range: student.week_program_range,
                          program_total: student.program_total,
                          accommodation_total: student.accommodation_total,
                          payments: student.payments,
                          evaluations: student.evaluations

      student.student_items.each do |student_item|
        sp = StudyPeriod.find_by(student_id: student_item.student_id)
        StudyPeriodItem.create! study_period_id: sp.id, item_id: student_item.item_id
      end

      student.fixed_duration_pro_students.each do |fdp|
        sp = StudyPeriod.find_by(student_id: fdp.student_id)
        StudyPeriodFixedProgram.create! study_period_id: sp.id, fixed_duration_program_id: fdp.fixed_duration_program_id
      end

      student.promos.each do |promo|
        sp = StudyPeriod.find_by(student_id: student.id)
        PromosStudyPeriod.create! study_period_id: sp.id, promo_id: promo.id
      end

      student.statements.each do |statement|
        sp = StudyPeriod.find_by(student_id: student.id)
        statement.update_attribute :study_period_id, sp.id
      end
    end
  end

  task :undo_study_period_migration => :environment do
    StudyPeriod.destroy_all
    StudyPeriodItem.destroy_all
    StudyPeriodFixedProgram.delete_all
  end

  task :rebirth => :environment do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_path, 20160917184002)
    Rake::Task["db:pull"].invoke
    Rake::Task["db:migrate"].invoke
  end

  task :birth_delivery => :environment do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_path, 20160917184002)
    Rake::Task["db:pull_secondary"].invoke
    Rake::Task["db:migrate"].invoke
  end

  task :birth_digital_ocean => :environment do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_path, 20160917184002)
    Rake::Task["db:pull_digital_ocean"].invoke
    Rake::Task["db:migrate"].invoke
  end

end
