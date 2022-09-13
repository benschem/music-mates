class Chatroom < ApplicationRecord
  belongs_to :group
  has_many :messages
  # has_many :users, through: :messages
  validates :name, presence: true
  # validates :user, uniqueness: {scope: :messages}
  # validates :concert_date, comparison: { greater_than: :end_date }
end
