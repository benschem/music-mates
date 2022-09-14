class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :landing

  def home; end
  def landing; end
end
