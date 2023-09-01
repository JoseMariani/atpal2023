class MigrateStudentData < ActiveRecord::Migration
  def up
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

  def down
    StudyPeriod.destroy_all
    StudyPeriodItem.destroy_all
    StudyPeriodFixedProgram.delete_all
  end
end
