class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  validates_presence_of :user_id
  validates :title, length: {minimum: 3}, presence: true
  validates :body, length: {minimum: 5}, presence: true
end
