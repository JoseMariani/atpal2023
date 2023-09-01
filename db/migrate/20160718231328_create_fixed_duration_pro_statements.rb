class CreateFixedDurationProStatements < ActiveRecord::Migration
  def change
    create_table :fixed_duration_pro_statements do |t|
      t.references :fixed_duration_program, index: true, foreign_key: true
      t.references :statement, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
