class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  validates_presence_of :user_id
end
