class RemoveCadiviColumnFromStudents < ActiveRecord::Migration
  def change
    remove_column :students, :cadivi
  end
end
