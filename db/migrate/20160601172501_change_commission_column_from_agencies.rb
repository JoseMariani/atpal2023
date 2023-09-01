class ChangeCommissionColumnFromAgencies < ActiveRecord::Migration
  def change
    change_column :agencies, :commission, :string
  end
end
