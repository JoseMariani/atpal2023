class AddTypeColumnToPromos < ActiveRecord::Migration
  def change
    add_column :promos, :type_of_promo, :string
  end
end
