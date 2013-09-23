# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    content { Faker::Lorem.paragraph(1) }
    votes { rand(10) }
    
    :restaurant
    :user
  end
end
