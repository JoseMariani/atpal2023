class AddPartialTotalColumnToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :partial_total, :decimal, precision: 7, scale: 2
  end
end
