class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.references :student, index: true, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :nacionality
      t.string :gender
      t.date :start_date
      t.date :end_date
      t.integer :duration_weeks
      t.string :age
      t.string :phone_number
      t.string :email_address
      t.string :type_of_accomodation
      t.string :type_of_program
      t.string :number_of_books
      t.string :number_of_hours
      t.decimal :registration_fee
      t.decimal :placement_fee
      t.boolean :custodianship_letter
      t.boolean :airport_pickup

      t.timestamps null: false
    end
  end
end
