class AddGradesToSpecialActivities < ActiveRecord::Migration
  def change
    add_column :special_activities, :research_grade, :string
    add_column :special_activities, :presentation_grade, :string
    add_column :special_activities, :written_grade, :string
  end
end
