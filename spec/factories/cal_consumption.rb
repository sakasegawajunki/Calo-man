FactoryBot.define do
  factory :cal_consumption do
    cal_consumption { Faker::Lorem.characters(number: 5) }
    base_cal_consumption { Faker::Lorem.characters(number: 5) }
  end
end
