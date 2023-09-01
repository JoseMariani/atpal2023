class AddValidDateColumnToPromos < ActiveRecord::Migration
  def change
    add_column :promos, :valid_until, :date
  end
end
