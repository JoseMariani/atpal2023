class AddDateOfValidityToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :date_of_validity, :date
  end
end
