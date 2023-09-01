class CreatePromosStudyPeriods < ActiveRecord::Migration
  def change
    create_table :promos_study_periods do |t|
      t.references :promo, index: true, foreign_key: true
      t.references :study_period, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
