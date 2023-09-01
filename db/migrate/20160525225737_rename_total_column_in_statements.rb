class RenameTotalColumnInStatements < ActiveRecord::Migration
  def change
    rename_column :statements, :total, :total_amount
  end
end
