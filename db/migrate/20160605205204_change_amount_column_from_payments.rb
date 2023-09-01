class ChangeAmountColumnFromPayments < ActiveRecord::Migration
  def change
    change_column :payments, :amount, :decimal, precision: 11, scale: 3
    change_column :statements, :balance, :decimal, precision: 11, scale: 3
  end
end
