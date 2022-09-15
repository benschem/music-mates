class Artist < ApplicationRecord
  has_many :follows
  has_many :users, through: :follows
  has_many :concerts, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :image_url, presence: true
  validates :spotify_link, presence: true
end
