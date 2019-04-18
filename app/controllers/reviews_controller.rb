class ReviewsController < ApplicationController
  before_action :set_flash_user, only: [:new]

  def new
    @review = Review.new
    @users = User.all_not(current_user)
  end

  def create
    @review = current_user.new_review(review_params)
    if @review.save
      current_user.create_notification(@review.user, @review)
      redirect_to user_path(review_params[:user_id])
    else
      render :new
    end
  end

  private
  def review_params
    params.require(:review).permit(:rating, :content, :user_id)
  end
end
