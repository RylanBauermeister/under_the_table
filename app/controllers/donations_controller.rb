class DonationsController < ApplicationController

  before_action :redirect_if_not_login

  def new
    @donation = Donation.new
  end

  def index
    @donations = current_user.donations_made
  end

  def create
    @donation = current_user.new_donation(donation_params)
    if @donation.save
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
