class MessagesController < ApplicationController

  def new
    @message = Message.new
    @users = User.all
  end

  def create
    @message = current_user.new_message(message_params)
    if @message.save
      current_user.create_notification(@message.receiver, @message)
      redirect_to users_messages_path(current_user)
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:receiver_id, :title, :content)
  end
end
