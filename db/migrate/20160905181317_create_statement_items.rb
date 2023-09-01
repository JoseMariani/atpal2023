class CreateStatementItems < ActiveRecord::Migration
  def change
    create_table :statement_items do |t|
      t.references :statement, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
