require "erb"
include ERB::Util

class ConcertsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]

  def index
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
end
