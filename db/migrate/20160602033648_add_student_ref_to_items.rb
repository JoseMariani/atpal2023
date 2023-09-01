class AddStudentRefToItems < ActiveRecord::Migration
  def change
    add_reference :items, :student, index: true, foreign_key: true
  end
end
