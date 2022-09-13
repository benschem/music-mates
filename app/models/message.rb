class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  validates :user, presence: true
end
