class AddAgencyRefToContacts < ActiveRecord::Migration
  def change
    add_reference :contacts, :agency, index: true, foreign_key: true
  end
end
