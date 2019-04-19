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
    @receiver = @donation.receiver
    #HOTFIX FOR LEGACY USERS
    current_user.update(balance: 1000) if current_user.balance == nil;
    @receiver.update(balance: 1000) if @receiver.balance == nil;
    if @donation.save
      current_user.create_notification(@donation.receiver, @donation)
      current_user.update(balance: current_user.balance - @donation.amount)

      @receiver.update(balance: @receiver.balance + @donation.amount)
      redirect_to donations_path
    else
      flash[:error_messages] = @donation.errors.full_messages
      redirect_to new_donation_path
    end
  end

  private
  def donation_params
    params.require(:donation).permit(:amount, :content, :receiver_id)
  end
end
