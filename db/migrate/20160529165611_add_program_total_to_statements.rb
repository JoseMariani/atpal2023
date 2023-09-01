class AddProgramTotalToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :program_total, :decimal, precision: 7, scale: 2
  end
end
