class InvitationsController < ApplicationController
  def index
    @invitations = current_user.invitations
  end

  def create; end

  def update
    @invitation = Invitation.find(params[:id])
    @invitation.status = params[:status].to_i
    @invitation.save
    sleep 2
    redirect_to invitations_path
  end
end
