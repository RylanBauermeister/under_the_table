class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?

  def redirect_if_not_login
    redirect_to login_path if !logged_in?
  end

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end
end
