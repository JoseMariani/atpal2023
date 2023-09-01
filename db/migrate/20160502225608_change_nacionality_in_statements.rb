class ChangeNacionalityInStatements < ActiveRecord::Migration
  def change
    rename_column :statements, :nacionality, :nationality
  end
end
