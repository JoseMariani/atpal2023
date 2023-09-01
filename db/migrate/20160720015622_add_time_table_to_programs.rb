class AddTimeTableToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :time_table, :string
    add_column :fixed_duration_programs, :time_table, :string
  end
end
