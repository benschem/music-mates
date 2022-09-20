require "erb"
include ERB::Util

class ConcertsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]

  def index
    current_user.artists.each do |artist|
      concerts = concerts_from_api_for(artist) # if error => concerts = false
      if concerts
        concerts.each do |concert|
          create_concert_unless_it_already_exists(concert, artist)
        end
      end
    end

    if params[:query].present?
      sql_query = "artists.name ILIKE :query"
      @concerts = Concert.joins(:artist).where(sql_query, query: "%#{params[:query]}%")
    else
      @concerts = current_user.concerts
    end
  end

  def show
    @concert = Concert.find(params[:id])
  end

  private

  def concerts_from_api_for(artist)
    potential_concerts = HTTParty.get("https://rest.bandsintown.com/artists/#{url_encode(artist.name)}/events?app_id=#{ENV["BANDS_IN_TOWN_KEY"]}&date=upcoming")
    p potential_concerts
    # returns array of concerts objects
    potential_concerts[0] && potential_concerts[0]["datetime"] ? potential_concerts : false
    # ⬆️ this line is protecting against empty/nil concerts being added
  end

  def  create_concert_unless_it_already_exists(concert, artist)
    Concert.where(artist: artist, date: DateTime.parse(concert["datetime"])).first_or_create(
      artist: artist,
      date: DateTime.parse(concert["datetime"]),
      location: concert["venue"]["location"],
      city: concert["venue"]["city"],
      country: concert["venue"]["country"],
      description: Rails::Html::FullSanitizer.new.sanitize(concert["description"]),
      venue: concert["venue"]["name"]
    )
  end
end
