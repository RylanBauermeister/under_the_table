class ApplicationController < ActionController::Base

  helper_method :current_user

  def redirect_if_not_login
    redirect_to login_path if !logged_in?
  end

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end

  def set_flash_user

    if flash[:receiver_id]
      @receiver_id = flash[:receiver_id]
    else
      @receiver_id = 1
    end
  end
end
