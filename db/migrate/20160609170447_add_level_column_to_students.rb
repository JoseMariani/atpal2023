class AddLevelColumnToStudents < ActiveRecord::Migration
  def change
    add_column :students, :level, :string
    add_column :students, :passport_picture, :string
    add_column :students, :certificate_picture, :string
  end
end
