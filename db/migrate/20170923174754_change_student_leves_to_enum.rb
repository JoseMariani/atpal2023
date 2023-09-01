class ChangeStudentLevesToEnum < ActiveRecord::Migration

  def up
    Student.all.each do |student|
      case student.try(:level).try(:downcase)
      when "unknown"
        student.update_attribute(:level, 0)
      when "int 1", "int i"
        student.update_attribute(:level, 1)
      when "int 2", "int ii"
        student.update_attribute(:level, 2)
      when "int 3", "int iii"
        student.update_attribute(:level, 3)
      when "adv 1", "adv i"
        student.update_attribute(:level, 4)
      when "adv 2", "adv ii"
        student.update_attribute(:level, 5)
      else
        student.update_attribute(:level, 0)
      end
    end
  end

end
