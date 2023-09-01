class ChangeNumberColumnFromPromos < ActiveRecord::Migration
  def change
    change_column :promos, :number, :decimal, precision: 6, scale: 4
  end
end
