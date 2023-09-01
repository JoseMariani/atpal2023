class AddDailyScoreToSns < ActiveRecord::Migration
  def change
    add_column :sharp_and_smarts, :daily_score, :decimal, precision: 5, scale: 2
    add_column :sharp_and_smarts, :daily_sns_count, :integer
  end
end