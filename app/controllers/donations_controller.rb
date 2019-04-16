class DonationsController < ApplicationController

  def new
    @donation = Donation.new
  end

  def create
    byebug
    @donation = current_user.new_donation(donation_params)
    if @donation.save
      redirect_to user_donations_path(current_user)
    else
      render :new
    end
  end

  private
  def donation_params
    params.require(:donation).permit(:amount, :content, :receiver_id)
  end
end
