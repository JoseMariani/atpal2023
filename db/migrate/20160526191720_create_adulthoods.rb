class CreateAdulthoods < ActiveRecord::Migration
  def change
    create_table :adulthoods do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
