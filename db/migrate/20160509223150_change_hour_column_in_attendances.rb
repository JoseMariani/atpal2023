class ChangeHourColumnInAttendances < ActiveRecord::Migration
  def change
    change_column :attendances, :hour, :datetime
  end
end
