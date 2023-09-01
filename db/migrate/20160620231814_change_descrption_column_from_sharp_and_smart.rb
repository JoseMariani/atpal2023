class ChangeDescrptionColumnFromSharpAndSmart < ActiveRecord::Migration
  def change
    rename_column(:sharp_and_smarts, :descrption, :description)
  end
end
