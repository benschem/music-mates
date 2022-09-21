require_relative "seed_repo"
require_relative "artist_repo"
require "open-uri"
require "erb"
include ERB::Util

# CLEANING DATABASE

puts "Cleaning database..."
User.destroy_all # if Rails.en.development
Artist.destroy_all # if Rails.en.development
Concert.destroy_all # if Rails.en.development
Group.destroy_all # if Rails.en.development
Invitation.destroy_all # if Rails.en.development
Follow.destroy_all # if Rails.en.development
Chatroom.destroy_all # if Rails.en.development
Message.destroy_all # if Rails.en.development
puts "Database cleaned."

# CREATE SOME DUMMY ARTISTS

puts "Creating some dummy artists..."

all_artists = []
@seed_artists.each do |artist|
  new_artist = Artist.create(
    artist
  )
  puts "#{new_artist.name} created!"
  all_artists << new_artist
end

# CREATE SOME DUMMY USERS

puts "Creating some dummy users..."

hunter = User.create!(
  first_name: "Micah",
  last_name: "Kim",
  email: "music@mates.com",
  password: "123456",
  location: "AU"
)
hunter.photo.attach(io: URI.open("https://res.cloudinary.com/benschem/image/upload/v1663733821/production/hunter-avatar_vkykjk.jpg"), filename: "hunters-avatar.png", content_type: "image/jpg")
puts "Micah Kim created! Email: music@mates.com, Password: 123456"

@classmates.each do |classmate|
  new_user = User.new(
    first_name: classmate[0],
    last_name: classmate[1],
    email: "#{classmate[0]}@#{classmate[1]}.com",
    password: "123456",
    location: "AU",
    avatar: Faker::Avatar.image,
  )
  new_user.photo.attach(io: URI.open(classmate[2]), filename: "#{classmate[0]}-avatar.png", content_type: "image/jpg")
  new_user.save
  puts "#{new_user.first_name} #{new_user.last_name} created!  Email: #{new_user.email}, Password: 123456"

  # CREATE SOME DUMMY FOLLOWS FOR OUR DUMMY USERS

  Follow.create(
    user: new_user,
    artist: Artist.find_by(name: "Stormzy")
  )
  puts "#{new_user.first_name} #{new_user.last_name} follows Stormzy"

  Follow.create(
    user: new_user,
    artist: Artist.find_by(name: "Kehlani")
  )
  puts "#{new_user.first_name} #{new_user.last_name} follows Kehlani"

  10.times do
    random_artist = all_artists.sample
    random_artist = all_artists.sample while new_user.follows.include?(random_artist)
    Follow.create(
      user: new_user,
      artist: random_artist
    )
    puts "#{new_user.first_name} #{new_user.last_name} follows #{random_artist.name}"
  end
end

# THESE API METHODS NEED TO BE DEFINED BEFORE WE CALL THEM

def concerts_from_api_for(artist)
  potential_concerts = HTTParty.get("https://rest.bandsintown.com/artists/#{url_encode(artist.name)}/events?app_id=#{ENV["BANDS_IN_TOWN_KEY"]}&date=upcoming")
  # returns array of concerts objects
  potential_concerts[0] && potential_concerts[0]["datetime"] ? potential_concerts : false
  # ⬆️ this line is protecting against empty/nil concerts being added
end

def  create_concert_unless_it_already_exists(concert, artist)
  new_concert = Concert.where(artist: artist, date: DateTime.parse(concert["datetime"])).first_or_create(
    artist: artist,
    date: DateTime.parse(concert["datetime"]),
    location: concert["venue"]["location"],
    city: concert["venue"]["city"],
    country: concert["venue"]["country"],
    description: Rails::Html::FullSanitizer.new.sanitize(concert["description"]),
    venue: concert["venue"]["name"],
    latitude: concert["venue"]["latitude"],
    longitude: concert["venue"]["longitude"]
  )
  puts "Created a concert in #{new_concert.city} for #{artist.name} on #{new_concert.date}."
end

# THIS IS WHERE WE MAKE THE BANDSINTOWN API CALL
all_users = User.all

puts "Making an API call to BandsInTown to get concerts for each user..."

all_users.each do |user|
  puts "Going through #{user.first_name}'s artists..."
  user.artists.each do |artist|
    puts "Looking up concerts for #{artist.name}..."
    artist_concerts = concerts_from_api_for(artist)
    if artist_concerts
      artist_concerts.each do |concert|
        if concert["venue"]["country"] == "Australia"
          create_concert_unless_it_already_exists(concert, artist)
        end
      end
    end
  end
end

# TODO: Pull concerts from other countries (matching user's spotify location)
# maybe use latitude and longitude to determine country
# concert["venue"]["country"] => "Australia"
# current_user.location => "AU"

puts "Done!"
