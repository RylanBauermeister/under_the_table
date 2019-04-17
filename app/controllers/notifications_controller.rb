class NotificationsController < ApplicationController

  def index
    @notifications = current_user.active_notifications
  end
end
