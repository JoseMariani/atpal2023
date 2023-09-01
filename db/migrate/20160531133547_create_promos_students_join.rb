class CreatePromosStudentsJoin < ActiveRecord::Migration
  def change
    create_table :promos_students do |t|
      t.references :promo, index: true, foreign_key: true
      t.references :student, index: true, foreign_key: true
    end
  end
end
