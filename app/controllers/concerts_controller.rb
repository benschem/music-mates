class ConcertsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home index]

  def index
    @concerts = Concert.all
  end

  def show
    @concert = Concert.find(params[:id])
  end


end
