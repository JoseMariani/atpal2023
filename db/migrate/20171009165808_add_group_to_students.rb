class AddGroupToStudents < ActiveRecord::Migration
  def change
    add_column :students, :group, :integer, :null => false, :default => 0
  end
end
