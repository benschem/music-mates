# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require_relative "seedrepo"

puts "Cleaning database..."
User.destroy_all # if Rails.en.development
Artist.destroy_all # if Rails.en.development
Concert.destroy_all # if Rails.en.development
Group.destroy_all # if Rails.en.development
Invitation.destroy_all # if Rails.en.development
Follow.destroy_all # if Rails.en.development
Chatroom.destroy_all # if Rails.en.development
Message.destroy_all # if Rails.en.development

User.create!(
  first_name: "Music",
  last_name: "Mates",
  email: "music@mates.com",
  password: "123456",
  location: "Melbourne",
  avatar: "seedimages/IMG_2579"
)
puts "Created User: Music Mates, Email: music@mates.com, Password: 123456."
puts "\n"

location = ["Melbourne", "Canberra", "Brisbane", "Hobart", "Sydney"]
venue = ["MCG", "The Pub", "Your Backyard", "Sydney Opera House", "McDonald's"]

# should use real artists
artists = []
10.times do
  a = Artist.create(
    name: Faker::Music.band,
    image_url: "https://imgs.smoothradio.com/images/191589?width=1200&crop=16_9&signature=GRazrMVlAISqkcXrrNA6ku356R0=",
    spotify_link: "https://open.spotify.com/artist/0gxyHStUsqpMadRV0Di1Qt"
  )
  puts "Created #{a.name}"
  artists << a
end

# should use real concerts
6.times do
  concert = Concert.create(
    date: Date.today,
    location: location.sample,
    description: Faker::Quotes::Shakespeare.hamlet_quote,
    venue: venue.sample,
    artist: artists.sample
  )
  puts "Created #{concert.artist.name}'s concert on #{concert.date} at #{concert.date}, #{concert.venue}."
end

r = [
"Pouya",
"Stormzy",
"Aitch",
"Central CEE",
"The Jezabels"
]

@user_images.each do |img|
  User.create!(
    first_name: img[0],
    last_name: "Wagon",
    email: Faker::Internet.safe_email,
    password: "123456",
    location: "Australia",
    avatar: img[1]
  )
end

30.times do
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.safe_email,
    password: "123456",
    location: "Australia",
    avatar: Faker::Avatar.image,
  )

  follow = Follow.create(
    artist: artists.sample,
    user: user
  )
  puts "#{user.first_name} follows #{follow.artist.name}."
end

puts "\n"

hunter = User.create(
  first_name: "Hunter",
  last_name: "Shark",
  location: "Sydney",
  email: "hunter@chomp.com",
  password: "123456",
  avatar: "seedimages/IMG_2579"
)
puts "#{hunter.first_name} has been born!"

5.times do
  random_artist = nil
  random_artist = artists.sample while hunter.artists.include?(random_artist)

  Follow.create!(
    artist: random_artist,
    user: hunter
  )
  puts "#{hunter.first_name} follows #{a.name}!"
end

group = Group.create(
  concert: Concert.first
)

invite = Invitation.create(
  user: hunter,
  group: group,
  status: 1
)

chatroom = Chatroom.create(
  group: group,
  name: "Shark Club"
)
puts "\n"

puts "Done!"
