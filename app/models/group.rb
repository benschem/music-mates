class Group < ApplicationRecord
  belongs_to :concert
  has_many :invitations
  has_many :users, through: :invitations

  validates :concert, presence: true
end
