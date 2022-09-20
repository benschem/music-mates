class Concert < ApplicationRecord
  belongs_to :artist
  has_many :groups, dependent: :destroy
  has_many :follows, through: :artist
  has_many :users, through: :follows

  default_scope { order(date: :desc) }

  validates :artist, presence: true
  validates :date, presence: true
  validates :venue, presence: true
  validates :location, presence: true
  validates :description, presence: true
end
