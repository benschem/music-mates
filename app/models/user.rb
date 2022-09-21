require "json"
require "open-uri"

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:spotify]

  has_many :invitations, dependent: :destroy
  has_many :groups, through: :invitations
  has_many :follows, dependent: :destroy
  has_many :artists, through: :follows
  has_many :concerts, through: :artists
  has_many :messages, dependent: :destroy

  has_one_attached :photo

  scope :without_me, ->(user) { where.not(id: user.id) }

  validates :location, presence: true
  validates :first_name, presence: true

  include PgSearch::Model
  pg_search_scope :search_users, against: {
    first_name: 'A',
    last_name: 'B'
  },
  using: {
    tsearch: { prefix: true }
  }

  def self.from_omniauth(auth)
    this_user = User.where(email: auth.extra.raw_info.email).first_or_create do |user|
      p user
      user.first_name = auth.info.name.split[0]
      user.last_name = auth.info.name.split[1]
      user.location = auth.info.country_code
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.password_confirmation = user.password
      # user.avatar = auth.info.image
      unless auth.info.image.nil?
        file = URI.open(auth.info.image)
        user.photo.attach(io: file, filename: "#{auth.info.name}.jpg", content_type: "image/png")
      end
    end

    # this_user.token = auth.credentials.token => uncomment this if we need to call Spotify API elsewhere in the app
    token = auth.credentials.token
    top_artists = this_user.get_top_artists(token)
    this_user.create_artists_and_follows(top_artists)
    this_user
  end

  def get_top_artists(token)
    url = "https://api.spotify.com/v1/me/top/artists?time_range=long_term&limit=50"
    endpoint = HTTParty.get(url, headers: {
      'Content-Type': "application/json",
      Authorization: "Bearer #{token}"
    })
    endpoint.parsed_response["items"] # array of artists
  end

  def create_artists_and_follows(top_artists)
    top_artists.each do |artist|
      artist = Artist.where(name: artist["name"]).first_or_create(
        name: artist["name"],
        image_url: artist["images"][0]["url"], # 640px by 640px pic of artist (sub 0 for 1 or 2 to get smaller pics)
        spotify_link: artist["external_urls"]["spotify"]
        #   WE COULD ADD THIS... 👇
        # genres: artist["genres"], # ["australian alternative rock", "australian indie", "australian pop"]
        #   ...but only if we're actually going to use it for something
        #   ...we'll either have to make a 'genres' table, or Jon suggests we use a gem 'acts as taggable'
      )
      Follow.where(user: self, artist: artist).first_or_create(user: self, artist: artist)
    end
  end
end
