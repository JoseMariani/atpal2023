class AddInsuranceCostColumnToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :insurance_cost, :decimal, precision: 7, scale: 2
  end
end
