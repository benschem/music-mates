class ConcertsController < ApplicationController
  def index
    @concerts = Concert.all
  end
end
