FactoryBot.define do
  factory :student do
    first_name Faker::Name.first_name
    last_name  Faker::Name.last_name
    date_of_bith Faker::Date.between(35.years.ago, 14.years.ago)
    nationality "Unknown"
    gender "Unknown"
    age "18"
  end
end
