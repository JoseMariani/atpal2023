class CreateStudentItems < ActiveRecord::Migration
  def change
    create_table :student_items do |t|
      t.references :student, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
