class ConcertsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]

  def index
    @concerts = Concert.all
    @users = User.all
  end

  def show
    @concert = Concert.find(params[:id])
    @follows = @concert.artist.follows
    @users = [] # replace this with search
    @follows.each { |f| @users << f.user}
  end
end
