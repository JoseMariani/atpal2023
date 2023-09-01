class CreatePromosStatementsJoin < ActiveRecord::Migration
  def change
    create_table :promos_statements do |t|
      t.references :promo, index: true, foreign_key: true
      t.references :statement, index: true, foreign_key: true
    end
  end
end
