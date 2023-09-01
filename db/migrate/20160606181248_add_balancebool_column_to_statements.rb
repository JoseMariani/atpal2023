class AddBalanceboolColumnToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :show_balance, :boolean
    add_column :statements, :show_bank_info, :boolean
  end
end
