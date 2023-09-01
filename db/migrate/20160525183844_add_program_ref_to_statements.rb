class AddProgramRefToStatements < ActiveRecord::Migration
  def change
    add_reference :statements, :program, index: true, foreign_key: true
  end
end
