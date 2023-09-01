class RemoveStudentStatementReferencesFromItems < ActiveRecord::Migration
  def change
    remove_reference(:items, :student, index: true, foreign_key: true)
    remove_reference(:items, :statement, index: true, foreign_key: true)
  end
end
