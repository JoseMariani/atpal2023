class AddAgencyRefToStudents < ActiveRecord::Migration
  def change
    add_reference :students, :agency, index: true, foreign_key: true
  end
end
