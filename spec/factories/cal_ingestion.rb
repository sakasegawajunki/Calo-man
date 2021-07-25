FactoryBot.define do
  factory :cal_ingestion do
    breakfast_cal { Faker::Lorem.characters(number: 5) }
    lunch_cal { Faker::Lorem.characters(number: 5) }
    dinner_cal { Faker::Lorem.characters(number: 5) }
    snack_cal { Faker::Lorem.characters(number: 5) }
  end
end
