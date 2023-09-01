class CreateSpecialActivities < ActiveRecord::Migration
  def change
    create_table :special_activities do |t|
      t.references :evaluation, index: true, foreign_key: true
      t.string :description
      t.date :date
      t.string :letter_grade

      t.timestamps null: false
    end
  end
end
