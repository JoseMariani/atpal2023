class ChangeStatusColumnInEvaluations < ActiveRecord::Migration
  def change
    add_column :evaluations, :status, :integer
  end
end
