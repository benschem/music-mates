class Concert < ApplicationRecord
  belongs_to :artist
  has_many :groups, dependent: :destroy

  validates :artist, presence: true
  validates :date, presence: true
  validates :venue, presence: true
  validates :location, presence: true
  validates :description, presence: true
end
