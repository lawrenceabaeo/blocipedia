# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wiki do
    title "MyString"
    description "MyString"
    access "MyString"
    user nil
  end
end
