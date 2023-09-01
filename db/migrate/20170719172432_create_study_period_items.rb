class CreateStudyPeriodItems < ActiveRecord::Migration
  def change
    create_table :study_period_items do |t|
      t.references :study_period, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
