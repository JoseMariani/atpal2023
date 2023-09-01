class AddInsuranceToStatements < ActiveRecord::Migration
  def change
    add_reference :statements, :insurance, index: true, foreign_key: true
  end
end
