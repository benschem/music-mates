class ChatroomsController < ApplicationController
  def show
    @group = Group.find(params[:id])
    @chatroom = @group.chatroom
    @message = Message.new
  end

  def create; end
end
