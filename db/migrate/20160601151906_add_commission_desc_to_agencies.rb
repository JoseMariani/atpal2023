class AddCommissionDescToAgencies < ActiveRecord::Migration
  def up
    change_column :agencies, :commission, :string
  end

  def down
    change_column :agencies, :commission, :decimal, precision: 7, scale: 2
  end
end
