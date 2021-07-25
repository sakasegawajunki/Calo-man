FactoryBot.define do
  factory :chat do
    message { Faker::Lorem.characters(number: 100) }
  end
end
