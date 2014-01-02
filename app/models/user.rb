class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :subscription
  has_many :wikis
  has_many :collaborators

  before_create :set_member

  private

  def set_member
    self.role = 'member'
  end

end
