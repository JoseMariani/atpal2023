class RemoveInsurancePolicyNumberFromStudents < ActiveRecord::Migration
  def change
    remove_column :students, :insurance_policy_number, :string
  end
end
