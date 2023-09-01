class AddTotalAfterPromosToFixedDurationPrograms < ActiveRecord::Migration
  def change
    add_column :fixed_duration_programs, :total_after_promos, :decimal, precision: 8, scale: 2
  end
end
