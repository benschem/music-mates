class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message.chatroom = @chatroom
    @message.user = current_user

    @message.save
    ChatroomChannel.broadcast_to(
      @chatroom,
      message: render_to_string(partial: "message", locals: {message: @message}),
      sender_id: @message.user.id
    )
    head :ok # don't sent to view, don't redirect/refresh
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
