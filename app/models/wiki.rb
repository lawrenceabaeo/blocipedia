class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  validates_presence_of :user_id
  # validates_presence_of :public_access
  validates :title, length: {minimum: 3}, presence: true
  validates :body, length: {minimum: 5}, presence: true
end
