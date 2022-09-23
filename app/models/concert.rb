class Concert < ApplicationRecord
  belongs_to :artist
  has_many :groups, dependent: :destroy
  has_many :follows, through: :artist
  has_many :users, through: :follows

  validates :artist, presence: true
  validates :date, presence: true
  validates :venue, presence: true
  validates :location, presence: true
  validates :description, presence: true

  default_scope { order(date: :asc) }
  # default_scope where {  }
  include PgSearch::Model
  pg_search_scope :search_concerts, against: {
    venue: 'B',
    city: 'C',
  },
    associated_against: {
      :artist => { :name => 'A' }
    },
    using: {
      tsearch: { prefix: true }
    }
end
