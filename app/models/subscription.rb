class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user
  validates :plan_id, presence: true
  validates :user_id, presence: true
  validates :stripe_customer_token, presence: true

  attr_accessor :stripe_card_token

  def save_with_payment
    if valid?
      email = current_user.email
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
  end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
  end
end
