class AddLessonsPerWeekColumnToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :lessons_per_week, :integer
  end
end
