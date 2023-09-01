class AddAgencyRefToStatements < ActiveRecord::Migration
  def change
    add_reference :statements, :agency, index: true, foreign_key: true
  end
end
