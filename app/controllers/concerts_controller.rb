class ConcertsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]

  def index
    @concerts = Concert.all
    # @concerts = HTTParty.get("https://rest.bandsintown.com/artists/The%20Jezabels/events?app_id=#{ENV["BANDS_IN_TOWN_KEY"]}&date=upcoming")
    # raise
    # current_user.artists.each do |artist|
    #   endpoint = HTTParty.get("https://rest.bandsintown.com/artists/#{artist.name}/events?app_id=5527da5d886f6cccbb484474f7b50f5d&date=upcoming")
    #   Concert.first_or_create(artist: artist, date: DateTime.parse(endpoint[0]["datetime"])) do |artist|
    #     artist: artist,
    #     date: DateTime.parse(endpoint[0]["datetime"])
    #     location: TODO
    #     description: Rails::Html::FullSanitizer.new.sanitize(@concerts[0]["description"])
    #     venue: TODO
    #   end
    # end
    # @concerts = current_user.concerts
  end

  def show
    @concert = Concert.find(params[:id])
  end


end
