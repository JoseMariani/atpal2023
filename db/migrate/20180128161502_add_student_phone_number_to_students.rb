class AddStudentPhoneNumberToStudents < ActiveRecord::Migration
  def change
    add_column :students, :student_phone_number, :string
  end
end
