# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "faker"
puts "Cleaning database..."

User.destroy_all # if Rails.en.development

puts "Creating Music Mates..."

User.create!(
  first_name: "Music",
  last_name: "Mates",
  email: "music@mates.com",
  password: "123456",
  location: "Melbourne"
)
puts "Created User: Music Mates, Email: music@mates.com, Password: 123456, Location: Melbourne."
