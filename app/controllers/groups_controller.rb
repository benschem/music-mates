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
    @follows = @concert.artist.follows
    if params[:query].present?
      sql_query = "users.first_name ILIKE :query OR users.last_name ILIKE :query"
      @users = User.where(sql_query, query: "%#{params[:query]}%")

    else
      @users = [] # replace this with search
      @follows.each { |f| @users << f.user }
    end
  end

  def show
    @group = Group.find(params[:id])
    @concert = Concert.find(@group.concert.id)
    @chatroom = Chatroom.find(@group.chatroom.id)
    @message = Message.new
  end

  def index
    # @groups = Group.joins(:invitations).where('invitations.user_id = ?', current_user.id)
    # @groups = current_user.groups
    @invites = Invitation.where(status: "accepted")
    @groups = []
    @invites.each do |invite|
      @groups << invite.group
    end
  end

  private

  def group_params
    params.require(:group).permit(:concert)
  end
end
