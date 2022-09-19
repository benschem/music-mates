class InvitationsController < ApplicationController
  def index
    @invitations = []
    current_user.invitations.each { |invite| @invitations << invite if invite.status == "accepted"}
  end

  def create; end

  def update
    @invitation = Invitation.find(params[:id])
    @invitation.status = params[:status].to_i
    @invitation.save
    redirect_to invitations_path
  end
end
