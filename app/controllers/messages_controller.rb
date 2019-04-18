class MessagesController < ApplicationController
  before_action :set_flash_user, only: [:new]

  def new
    @message = Message.new
    @other_users = User.all_not(current_user)
  end

  def create
    user = current_user
    @message = current_user.new_message(message_params)
    if @message.save
      current_user.create_notification(@message.receiver, @message)
      redirect_to message_thread_path(@message.receiver)
    else
      render :new
    end
  end

  def inbox
    @user = current_user
    other_users = User.all_not(current_user)
    @users_corresponded_with = @user.messages_sent.collect {|m| other_users.find(m.receiver_id)}
    @users_corresponded_with << @user.messages_received.collect {|m| other_users.find(m.sender_id)}
    @users_corresponded_with.flatten!.uniq!
  end

  def message_thread
    @user = current_user
    @receiver = User.find(params[:receiver_id])
    messages = Message.all.select {|m| m.sender == @user && m.receiver == @receiver}
    messages << Message.all.select {|m| m.sender == @receiver && m.receiver == @user}
    messages.flatten!
    @messages_sorted = messages.sort_by {|m| m.created_at}.reverse
    current_user.clear_message_notifications(@receiver)
  end

  private

  def message_params
    params.require(:message).permit(:receiver_id, :title, :content)
  end
end
