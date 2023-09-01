class AddEntireStayDurationToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :entire_stay_duration, :string
    add_column :statements, :accommodation_duration, :string
  end
end
