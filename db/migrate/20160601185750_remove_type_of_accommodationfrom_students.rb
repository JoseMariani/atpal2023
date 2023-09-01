class RemoveTypeOfAccommodationfromStudents < ActiveRecord::Migration
  def change
    remove_column :statements, :type_of_accomodation
    remove_column :students, :type_of_accomodation
  end
end
