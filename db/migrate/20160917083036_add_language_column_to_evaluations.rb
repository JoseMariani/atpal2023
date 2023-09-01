class AddLanguageColumnToEvaluations < ActiveRecord::Migration
  def change
    add_column :evaluations, :language, :string
  end
end
