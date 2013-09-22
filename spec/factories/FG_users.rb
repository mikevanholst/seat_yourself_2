# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name}
    email { Faker::Internet.email}
    phone { Faker::PhoneNumber.phone_number}
    password 'test'
    password_confirmation 'test'
    owner false
  end
end
