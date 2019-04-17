class User < ApplicationRecord
  has_secure_password
  validates :password, confirmation: true

  has_many :donations_made, :class_name => "Donation", :foreign_key => "sender_id"
  has_many :donations_received, :class_name => "Donation", :foreign_key => "receiver_id"

  has_many :messages_sent, :class_name => "Message", :foreign_key => "sender_id"
  has_many :messages_received, :class_name => "Message", :foreign_key => "receiver_id"

  has_many :reviews_written, :class_name => "Review", :foreign_key => "writer_id"
  has_many :reviews, :class_name => "Review", :foreign_key => "user_id"

  has_many :notifications

  def new_donation(params)
    Donation.new(sender: self, receiver_id: params[:receiver_id], amount: params[:amount], content: params[:content])
  end

  def new_message(params)
    Message.new(sender: self, receiver_id: params[:receiver_id], title: params[:title], content: params[:content])
  end

  def new_review(params)
    Review.new(writer: self, user_id: params[:user_id], rating: params[:rating], content: params[:content])
  end

  def create_notification(user, content)
    Notification.create(user: user, content: content)
  end

  def active_notifications
    notifications.where(active: true)
  end

  def self.all_not(user)
    User.where.not(id: user.id)
  end

end
