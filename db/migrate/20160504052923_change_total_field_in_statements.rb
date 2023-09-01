class ChangeTotalFieldInStatements < ActiveRecord::Migration
  def change
    change_column :statements, :total, :decimal, :precision => 7, :scale => 2
  end
end
