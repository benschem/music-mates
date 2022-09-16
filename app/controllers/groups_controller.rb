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
    if @group.save
      Invitation.create(invitations)
      Chatroom.create(group: @group, name: @concert.artist.name)
      redirect_to group_path(@group)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @users = User.all
    @concert = Concert.find(params[:concert_id])
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
    @concert = Concert.find(@group.concert.id)
    @chatroom = Chatroom.find(@group.chatroom.id)
    @message = Message.new
  end

  private

  def group_params
    params.require(:group).permit(:concert)
  end
end
