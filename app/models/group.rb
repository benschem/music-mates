class Group < ApplicationRecord
  belongs_to :concert
  has_many :chatrooms, dependent: :destroy
  has_many :invitations
  has_many :users, through: :invitations
  has_one :chatroom

  validates :concert, presence: true
end
