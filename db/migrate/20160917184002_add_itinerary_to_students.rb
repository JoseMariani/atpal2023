class AddItineraryToStudents < ActiveRecord::Migration
  def change
    add_column :students, :itinerary, :string
  end
end
