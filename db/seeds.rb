# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user1 = User.create([{first_name: "Ben", last_name: "Schem", location: "Melbourne"}])
artist1 = Artist.create([{name: "Central Cee"}])
concert1 = Concert.create([{date: Date.today, location: "Melbourne", description: "My bitch is gay", venue: "Forum"}])

concert1.artist = artist1

follows1 = Follow.create

follows1.artist = artist1
follows1.user = user1
