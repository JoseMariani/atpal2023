class PlacementFee < ActiveRecord::Base
  belongs_to :item
  has_many :placement_fees
end
