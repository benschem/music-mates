class Artist < ApplicationRecord
  has_many :follows
  has_many :users, through: :follows
  has_many :concerts, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
