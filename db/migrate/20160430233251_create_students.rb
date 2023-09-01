class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :nationality
      t.string :gender
      t.date :start_date
      t.date :end_date
      t.integer :duration_weeks
      t.string :age
      t.string :phone_number
      t.string :email_address
      t.string :passport_number
      t.string :type_of_accomodation
      t.string :type_of_program
      t.integer :number_of_books
      t.text :emergency_contact
      t.text :residential_address
      t.text :address_in_canada
      t.integer :number_of_hours

      t.timestamps null: false
    end
    add_index :students, :last_name
    add_index :students, :date_of_birth
    add_index :students, :nationality
    add_index :students, :start_date
    add_index :students, :end_date
  end
end
