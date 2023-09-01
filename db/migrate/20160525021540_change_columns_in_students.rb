class ChangeColumnsInStudents < ActiveRecord::Migration
  def change
    rename_column :students, :documents_sent?, :documents_sent
    rename_column :students, :visa?, :visa
    rename_column :students, :air_ticket?, :air_ticket
    rename_column :students, :certificate_issued?, :certificate_issued
    rename_column :students, :insurance?, :insurance
  end
end
