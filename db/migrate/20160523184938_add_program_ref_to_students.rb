class AddProgramRefToStudents < ActiveRecord::Migration
  def change
    add_reference :students, :program, index: true, foreign_key: true
  end
end
