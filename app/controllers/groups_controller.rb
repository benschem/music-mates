class GroupsController < ApplicationController
  def create
    @concert = Concert.find(params[:concert_id])
    @group = Group.new(concert: @concert)
    invitations = []
    selected_users = User.where(id: params[:user_ids])
    selected_users.each do |selected_user|
      invitations << {
        group: @group,
        user: selected_user
      }
    end
    if @group.save
      Invitation.create(invitations)
      my_own_invite = Invitation.new(group: @group, user: current_user)
      my_own_invite.status = "accepted"
      my_own_invite.save
      Chatroom.create(group: @group, name: @concert.artist.name)
      redirect_to group_path(@group)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @concert = Concert.find(params[:concert_id])
    @group = Group.new
    # users who are following the same artist. The artist is connected through the concert
    if params[:query].present?
      @users = User.search_users(params[:query])
    else
      @users = User.joins(:follows, :artists, :concerts).where('concerts.id = ?', @concert.id).uniq
    end
  end

  def show
    @group = Group.find(params[:id])
    @concert = Concert.find(@group.concert.id)
    @message = Message.new

    @accepted_invitations = @group.invitations.where(status: "accepted").includes(:user)
    @pending_invitations = @group.invitations.where(status: "pending").includes(:user)
  end

  def index
    # @groups = Group.joins(:invitations).where('invitations.user_id = ?', current_user.id)
    @groups = Group.joins(:invitations).where('invitations.user_id = ? AND invitations.status = ?', current_user.id, 1)
    # @groups = current_user.groups
    @invites = @groups.map { |group| group.invitations }.flatten
  end

  private

  def group_params
    params.require(:group).permit(:concert)
  end
end
