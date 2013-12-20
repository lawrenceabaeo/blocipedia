class Plan < ActiveRecord::Base

  has_many :subscriptions
  validates :name, presence: true
  validates :price, presence: true

end
