require "json"

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:spotify]

  has_many :invitations, dependent: :destroy
  has_many :groups, through: :invitations
  has_many :follows, dependent: :destroy
  has_many :artists, through: :follows
  has_many :messages

  has_one_attached :photo

  validates :location, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.from_omniauth(auth)
    where(email: auth.email).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end

    # Get the temp token
    token = auth.credentials.token
    # Figure out how to get new user's top artists
    url = "https://api.spotify.com/v1/me/top/artists"
    endpoint = HTTParty.get(url, headers: {
      'Content-Type': "application/json",
      Authorization: "Bearer #{token}"
    })

    artists = endpoint.parsed_response["items"] # array of artists
    artists.each do |artist|
      artist["name"] # The Jezabels
      artist["images"][0]["url"] # 640px by 640px pic of artist
      artist["genres"] # ["australian alternative rock", "australian indie", "australian pop"]
      artist["external_urls"]["spotify"] # "https://open.spotify.com/artist/76KHdORVQMt7L6nVzvOUph"
    end

    raise
    # Create all the followings for the current user

    # TODO: Login devise with spotify
  end
end
