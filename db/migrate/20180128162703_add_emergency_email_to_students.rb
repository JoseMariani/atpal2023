class AddEmergencyEmailToStudents < ActiveRecord::Migration
  def change
    add_column :students, :emergency_email, :string
  end
end
