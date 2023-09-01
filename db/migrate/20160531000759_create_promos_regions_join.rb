class CreatePromosRegionsJoin < ActiveRecord::Migration
  def change
    create_table :promos_regions do |t|
      t.references :promo, index: true, foreign_key: true
      t.references :region, index: true, foreign_key: true
    end
  end
end
