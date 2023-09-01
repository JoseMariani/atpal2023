class RenamePartialTotalColumnFromStudents < ActiveRecord::Migration
  def change
    rename_column :statements, :partial_total, :program_cost
  end
end
