class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    # everyone in chatroom talks in chatroom thus only one channel/chatroom
    chatroom = Chatroom.find(params[:id])
    stream_for chatroom
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
