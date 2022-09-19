require "erb"
include ERB::Util

class ConcertsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]

  def index
    # current_user.artists.each do |artist|
    #   concerts = concerts_from_API_for(artist)
    #   concerts.each do |concert|
    #     create_concert_unless_it_already_exists(concert, artist)
    #   end
    # end
    @concerts = current_user.concerts # Testing purposes only!

    # follows = current user's

    # sql_query = "title ILIKE :query OR synopsis ILIKE :query"
    # @movies = Movie.where(sql_query, query: "%#{params[:query]}%")

    # @concerts = current_user.concerts
    # @users = User.all
  end

  def show
    @concert = Concert.find(params[:id])
    @follows = @concert.artist.follows
    @users = [] # replace this with search
    @follows.each { |f| @users << f.user}
  end

  private

  def concerts_from_API_for(artist)
    HTTParty.get("https://rest.bandsintown.com/artists/#{url_encode(artist.name)}/events?app_id=#{ENV["BANDS_IN_TOWN_KEY"]}&date=upcoming")
    # returns array of concert objects
  end

  def  create_concert_unless_it_already_exists(concert, artist)
    Concert.where(artist: artist, date: DateTime.parse(concert["datetime"])).first_or_create(
      artist: artist,
      date: DateTime.parse(concert["datetime"]),
      location: concert["venue"]["location"],
      description: Rails::Html::FullSanitizer.new.sanitize(concert["description"]),
      venue: concert["venue"]["name"]
    )
  end

end
