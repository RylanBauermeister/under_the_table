class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  before_action :redirect_if_not_login, except: [:new, :create]
  before_action :is_own_page, only: [:show]

  def index
    if params[:search]
      search = params[:search].downcase
      @users = User.all.select{|user|
        user.username.downcase.include?(search) || user.profession.downcase.include?(search)
      }
    else
      @users = User.all
    end

  end

  def show
    @reviews = @user.reviews.sort_by {|review| review.created_at}.reverse
    if is_own_page
      @notifications = current_user.active_notifications
      current_user.clear_review_notifications
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    if current_user == @user
      @user.destroy
      session.delete :user_id
    end
    redirect_to users_path
  end

  def morph
    @user = User.find(params[:user_id])
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :profession, :location, :profile_picture_url, :password, :password_confirmation)
  end

  def is_own_page
    @is_own_page = @user == User.find(session[:user_id])
  end
end
