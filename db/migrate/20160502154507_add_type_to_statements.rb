class AddTypeToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :type, :string
  end
end
