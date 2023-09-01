class ChangeAbsentColumnInAttendances < ActiveRecord::Migration
  def change
    change_column :attendances, :absent, :string
  end
end
