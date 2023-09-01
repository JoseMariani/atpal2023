class StatementItem < ActiveRecord::Base
  belongs_to :statement
  belongs_to :item

  accepts_nested_attributes_for :item, reject_if: :all_blank
end
