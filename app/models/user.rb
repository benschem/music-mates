class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :invitations, dependent: :destroy
  has_many :groups, through: :invitations
  has_many :follows, dependent: :destroy
  has_many :artists, through: :follows

  has_one_attached :photo

  validates :location, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_username,
    against: [ :username],
    using: {
      tsearch: { prefix: true }
    }

end
