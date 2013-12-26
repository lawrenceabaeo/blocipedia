class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user
  validates :plan_id, presence: true
  validates :user_id, presence: true
  

  attr_accessor :stripe_card_token

  def save_with_payment(user)
    self.user_id = user.id
    if valid?
      email = user.email
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      puts "The self.stripe_card_token is: #{self.stripe_card_token}"
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
      puts "The customer.inspect output is: " 
      puts customer.inspect
      puts "AFFER the customer.inspect output"
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"  
      self.stripe_customer_token = customer.id
      save!
  end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
  end
end
