class RemoveNumberOfHoursFromProgram < ActiveRecord::Migration
  def change
    remove_column :programs, :number_of_hours
  end
end
