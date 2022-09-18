class GroupsController < ApplicationController
  def create
    @concert = Concert.find(params[:concert_id])
    @group = Group.new(concert: @concert)
    invitations = []
    users = User.where(id: params[:user_ids])
    users.each do |user|
      invitations << {
        group: @group,
        user: user
      }
    end
    invitations << {group: @group, user: current_user}
    if @group.save
      Invitation.create(invitations)
      current_user.invitations.last.status = "accepted"
      Chatroom.create(group: @group, name: @concert.artist.name)
      redirect_to group_path(@group)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @concert = Concert.find(params[:concert_id])
    @group = Group.new
    @follows = @concert.artist.follows
    @users = [] # replace this with search
    @follows.each { |f| @users << f.user}
  end

  def show
    @group = Group.find(params[:id])
    @concert = Concert.find(@group.concert.id)
    @chatroom = Chatroom.find(@group.chatroom.id)
    @message = Message.new
  end

  def index
    @groups = Group.joins(:invitations).where('invitations.user_id = ?', current_user.id)
  end

  private

  def group_params
    params.require(:group).permit(:concert)
  end
end
