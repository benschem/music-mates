class Chatroom < ApplicationRecord
  belongs_to :group
  validates :concert, presence: true
  # validates :concert_date, comparison: { greater_than: :end_date }
end
