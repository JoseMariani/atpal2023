class AddRegionReferenceToStatements < ActiveRecord::Migration
  def change
    add_reference :statements, :region, index: true, foreign_key: true
  end
end
