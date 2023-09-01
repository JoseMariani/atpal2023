class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :evaluation, index: true, foreign_key: true
      t.time :hour
      t.boolean :absent

      t.timestamps null: false
    end
  end
end
