class AddRegionReferenceToStudents < ActiveRecord::Migration
  def change
    add_reference :students, :region, index: true, foreign_key: true
  end
end
