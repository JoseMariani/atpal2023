class ActivateStudentJob < ActiveJob::Base
  queue_as :default

  def perform(student)
    unless student.status == 'Active' || student.status == 'active'
      student.update_attribute(:status, 'Active')
    end
    if student.student_id.nil? || student.student_id.blank? || student.student_id.empty?
      id = '90'+ (Student.where(:status => 'graduate').count + Student.where(:status => 'active').count).to_s
      until Student.find_by_student_id(id).nil?
        id = '90'+ (Student.where(:status => 'graduate').count + Student.where(:status => 'active').count + 1).to_s
      end
      student.update_attribute(:student_id, id)
    end
  end
end
