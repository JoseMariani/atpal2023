class CreateFixedDurationProgramsPromosJoin < ActiveRecord::Migration
  def change
    create_table :fixed_duration_programs_promos, :id => false do |t|
      t.references :fixed_duration_program, index: {:name => :fdp_promo}, foreign_key: true
      t.references :promo, index: true, foreign_key: true
    end
  end
end
