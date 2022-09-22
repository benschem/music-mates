class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @top_artists = @user.artists.first(10)
  end

  def search
    user = User.search_users(params[:query])
    redirect_to profile_path(user.ids[0])
  end
end
