class AddFieldsToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :grade, :decimal, precision: 4, scale: 2
    add_column :attendances, :penalty, :decimal, precision: 4, scale: 2
  end
end
