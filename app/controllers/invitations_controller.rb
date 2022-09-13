class InvitationsController < ApplicationController

  def index
    @invitations = Invitations.all
  end

end
