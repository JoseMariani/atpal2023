class ChangeimageColumnInDigitalTests < ActiveRecord::Migration
  def change
    rename_column :digital_tests, :image, :attachment
  end
end
