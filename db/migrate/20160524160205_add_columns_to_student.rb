class AddColumnsToStudent < ActiveRecord::Migration
  def change
    add_column :students, :insurance?, :string
    add_column :students, :insurance_policy_number, :string
    add_column :students, :caq, :string
    add_column :students, :study_permit, :string
    add_column :students, :total_amount, :string
    add_column :students, :balance, :string
    add_column :students, :documents_sent?, :string
    add_column :students, :visa?, :string
    add_column :students, :cadivi, :string
    add_column :students, :air_ticket?, :string
    add_column :students, :arrival_date, :string
    add_column :students, :certificate_issued?, :string
  end
end
