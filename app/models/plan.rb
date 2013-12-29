class Plan < ActiveRecord::Base

  has_many :subscriptions
  validates :name, presence: true
  validates :price, presence: true

  def self.monthly
    Plan.find_by name: "Five Dollars A Month"
  end

end
