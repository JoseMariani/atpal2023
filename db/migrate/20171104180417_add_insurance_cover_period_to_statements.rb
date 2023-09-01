class AddInsuranceCoverPeriodToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :insurance_cover_period, :integer
  end
end
