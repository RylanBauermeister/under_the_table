class StaticController < ApplicationController

  def login
  end

  def attempt_login
    @user = User.find_by(username: params[:username]).authenticate(params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:message] = "Invalid login.  Please try again."
      redirect_to login_path
    end
  end

  def index
    session.include?(:user_id) ? @path = user_path(User.find(session[:user_id])) : @path = login_path
    render layout: false
  end
end
