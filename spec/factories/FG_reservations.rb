# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reservation do
    party_size { 2 + rand(18) }
    day {Time.now + rand(2).day }
    meal_time {Time.now.change(:hour => (11 + rand(9))) }
    :restaurant
  end
end
