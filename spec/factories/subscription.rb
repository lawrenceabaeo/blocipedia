# spec/factories/subscription.rb

FactoryGirl.define do
  factory :subscription do
    # had to use this guide:
    # https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
    user
    plan_id { Plan.monthly.id }
    stripe_customer_token "fakeStripeTokenHere"
  end
end