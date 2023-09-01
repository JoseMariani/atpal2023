class AddAccommodationTotalColumnToStudents < ActiveRecord::Migration
  def change
    add_column :students, :accommodation_total, :decimal, precision: 7, scale: 2
  end
end
