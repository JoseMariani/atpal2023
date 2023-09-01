class AddAccommodationDurationToStudents < ActiveRecord::Migration
  def change
    add_column :students, :accommodation_duration, :integer
  end
end
