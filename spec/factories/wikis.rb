# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wiki do
    title "My Title String"
    body "My Body String"
    user # I guess factory girl is smart enough to create a user, just by magically having the user stated here
  end
end
