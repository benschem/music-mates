class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :invitations
  has_many :groups, through: :invitations
  has_many :follows
  has_many :artists, through: :follows
  has_many :messages
  has_many :chatrooms, through: :messages

  validates :location, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
