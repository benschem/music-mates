class InvitationsController < ApplicationController
  def index
    @invitations = current_user.invitations
  end

  def create; end

  def accept
    @invitation = Invitation.find(params[:id])
    @invitation.accepted!
    sleep 2
    redirect_to concerts_path
  end

  def decline
    @invitation = Invitation.find(params[:id])
    @invitation.declined!
    redirect_to invitations_path
  end
end
