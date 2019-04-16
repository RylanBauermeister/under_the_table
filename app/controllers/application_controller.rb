class ApplicationController < ActionController::Base

  def redirect_if_not_login
    redirect_to login_path if !logged_in?
  end

  def logged_in?
    !!session[:user_id]
  end
end
