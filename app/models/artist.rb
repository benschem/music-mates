class Artist < ApplicationRecord
  has_many :follows
  has_many :users, through: :follows

  validates :name, presence: true, uniqueness: true
end
