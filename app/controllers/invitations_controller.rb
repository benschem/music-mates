class InvitationsController < ApplicationController

  def index
    @invitations = Invitations.all
  end

  def create; end
end
