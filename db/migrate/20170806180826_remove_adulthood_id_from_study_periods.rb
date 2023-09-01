class RemoveAdulthoodIdFromStudyPeriods < ActiveRecord::Migration
  def up
    remove_reference :study_periods, :adulthood, index: true, foreign_key: true
  end

  def down
    add_reference :study_periods, :adulthood, index: true
  end
end
