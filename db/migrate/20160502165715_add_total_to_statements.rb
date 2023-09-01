class AddTotalToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :total, :decimal
  end
end
