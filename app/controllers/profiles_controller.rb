class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @top_artists = @user.artists.first(10)
  end

  def search
    # Search based on what the user typed in
    ##  params[:query] gives what user typed in
    # Get the user
    user = User.find_by("first_name ILIKE ?", "%#{params[:query]}%")
    # Call the show action to display the user
    redirect_to profile_path(user)
  end
end
