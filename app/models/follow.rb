class Follow < ApplicationRecord
  belongs_to :artist
  belongs_to :user

  validates :artist, uniqueness: { scope: :user }
end
