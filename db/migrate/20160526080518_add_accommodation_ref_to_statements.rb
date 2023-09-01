class AddAccommodationRefToStatements < ActiveRecord::Migration
  def change
    add_reference :statements, :accommodation, index: true, foreign_key: true
  end
end
