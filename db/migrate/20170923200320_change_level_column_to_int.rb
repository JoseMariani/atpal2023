class ChangeLevelColumnToInt < ActiveRecord::Migration
  def up
    change_column :students, :level, :integer, :null => false, :default => 0
  end

  def down
    change_column :students, :level, :string
  end
end
