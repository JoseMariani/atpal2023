class AddPostRebateProgramCostColumnToQuotes < ActiveRecord::Migration
  def change
    add_column :statements, :post_rebate_program_cost, :integer
  end
end
