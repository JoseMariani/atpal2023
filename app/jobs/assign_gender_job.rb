class AssignGenderJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    d = GenderDetector.new(:case_sensitive => false)
    students = Student.all
    students.each do |student|
      if student.gender.nil?
        first_name = (student.first_name.strip.split(/\s+/))[0]
        if d.get_gender(first_name) == :andy
          student.update_attribute(:gender, 'not assigned')
        else
          student.update_attribute(:gender, d.get_gender(first_name))
        end
      end
    end
  end
end
