class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.date :date
      t.decimal :amount, precision: 7, scale: 3
      t.references :student, index: true, foreign_key: true
      t.references :statement, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
