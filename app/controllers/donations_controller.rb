class DonationsController < ApplicationController

  before_action :redirect_if_not_login
  before_action :set_flash_user, only: [:new]

  def new
    @donation = Donation.new
    @other_users = User.all_not(current_user)
  end

  def index
    @donations_made = current_user.donations_made
    @donations_received = current_user.donations_received

    #Clear donation notifications
    current_user.clear_donation_notifications
  end

  def create
    @donation = current_user.new_donation(donation_params)
    if @donation.save
      current_user.create_notification(@donation.receiver, @donation)
      redirect_to donations_path
    else
      render :new
    end
  end

  private
  def donation_params
    params.require(:donation).permit(:amount, :content, :receiver_id)
  end
end
