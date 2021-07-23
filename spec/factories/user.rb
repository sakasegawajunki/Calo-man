FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    name_kana { Faker::Lorem.characters(number: 10) }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    encrypted_password { '12345678' }
    height { Faker::Lorem.characters(number: 5) }
    weight { Faker::Lorem.characters(number: 5) }
    age { Faker::Lorem.characters(number: 3) }
    password { "12345678" }
    sex { "男性" }
  end
end
