class ConcertsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home index]
end
