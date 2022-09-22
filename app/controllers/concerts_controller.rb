require "erb"
include ERB::Util

class ConcertsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]

  def index
    if params[:query].present?
      @concerts = Concert.search_concerts(params[:query])
    else
      @concerts = current_user.concerts
    end
  end

  def show
    @concert = Concert.find(params[:id])
  end

  def fetch_concerts
    check_for_new_concerts
    redirect_to concerts_path
  end

  private

  def check_for_new_concerts
    current_user.artists.each do |artist|
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

  def concerts_from_api_for(artist)
    potential_concerts = HTTParty.get("https://rest.bandsintown.com/artists/#{url_encode(artist.name)}/events?app_id=#{ENV["BANDS_IN_TOWN_KEY"]}&date=upcoming")
    potential_concerts[0] && potential_concerts[0]["datetime"] ? potential_concerts : false
  end

  def create_concert_unless_it_already_exists(concert, artist)
    Concert.where(artist: artist, date: DateTime.parse(concert["datetime"])).first_or_create(
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
  end
end
