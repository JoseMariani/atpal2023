class AddPaymentboolColumnToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :show_payments, :boolean
  end
end
