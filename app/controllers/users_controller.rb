class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  before_action :redirect_if_not_login, except: [:new, :create]
  before_action :is_own_page, only: [:show]



  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  def donate

  end

  def donations

  end

  def messages
    @user = current_user
    @users_corresponded_with = current_user.messages_sent.collect {|m| User.find(m.receiver_id)}.uniq
  end

  def message_thread
    @user = current_user
    messages = Message.all.select {|m| m.sender_id == @user.id && m.receiver_id == params[:receiver_id].to_i}
    messages << Message.all.select {|m| m.sender_id == params[:receiver_id].to_i && m.receiver_id == @user.id}
    messages.flatten!
    @messages_sorted = messages.sort_by {|m| m.created_at}
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :profession, :location, :profile_picture_url, :password, :password_confirmation)
  end

  def is_own_page
    @is_own_page = @user == User.find(session[:user_id])
  end
end
