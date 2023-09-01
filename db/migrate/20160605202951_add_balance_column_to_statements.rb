class AddBalanceColumnToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :balance, :decimal, precision: 8, scale: 3
  end
end
