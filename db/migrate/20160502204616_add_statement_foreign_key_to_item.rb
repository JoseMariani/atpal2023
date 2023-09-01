class AddStatementForeignKeyToItem < ActiveRecord::Migration
  def change
    add_reference :items, :statement, index: true, foreign_key: true
  end
end
