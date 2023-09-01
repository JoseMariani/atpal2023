class AddAccommodationRefToStudents < ActiveRecord::Migration
  def change
    add_reference :students, :accommodation, index: true, foreign_key: true
  end
end
