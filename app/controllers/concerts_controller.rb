class ConcertsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]

  def index
    @concerts = Concert.all
    @users = User.all
    # @concerts = HTTParty.get("https://rest.bandsintown.com/artists/The%20Jezabels/events?app_id=#{ENV["BANDS_IN_TOWN_KEY"]}&date=upcoming")
    # raise
    # current_user.artists.each do |artist|
    #   endpoint = HTTParty.get("https://rest.bandsintown.com/artists/#{artist.name}/events?app_id=#{ENV["BANDS_IN_TOWN_KEY"]}&date=upcoming")
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
    @follows = @concert.artist.follows
    @users = [] # replace this with search
    @follows.each { |f| @users << f.user}
  end
end
