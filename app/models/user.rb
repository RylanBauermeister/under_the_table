class User < ApplicationRecord
  has_secure_password
  validates :password, confirmation: true

  has_many :donations_made, :class_name => "Donation", :foreign_key => "sender_id", dependent: :destroy
  has_many :donations_received, :class_name => "Donation", :foreign_key => "receiver_id", dependent: :destroy

  has_many :messages_sent, :class_name => "Message", :foreign_key => "sender_id", dependent: :destroy
  has_many :messages_received, :class_name => "Message", :foreign_key => "receiver_id", dependent: :destroy

  has_many :reviews_written, :class_name => "Review", :foreign_key => "writer_id", dependent: :destroy
  has_many :reviews, :class_name => "Review", :foreign_key => "user_id", dependent: :destroy

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

  def clear_notifications(n)
    n.each do |notification|
      notification.update(active: false)
    end
  end

  def clear_message_notifications(user)
    message_notifications.each {|notification|
      if !notification.content.nil? && notification.content.receiver == self && notification.content.sender == user
        notification.update(active: false)
      end
    }
  end

  def clear_review_notifications
    clear_notifications(review_notifications)
  end

  def clear_donation_notifications
    clear_notifications(donation_notifications)
  end

  def message_notifications_with(user)
    messages = message_notifications.map do |notification|
      notification.content
    end
    messages.select {|message|
      !message.nil? && message.receiver == self && message.sender == user
    }
  end

  def message_notifications
    @n = notifications.where(active: true, content_type: "Message")
    @n.select{|m| !m.nil? }
  end

  def donation_notifications
    notifications.where(active: true, content_type: "Donation")
  end

  def review_notifications
    notifications.where(active: true, content_type: "Review")
  end

  def self.all_not(user)
    User.where.not(id: user.id)
  end

  def chronological_messages(user)
    messages.select{|m| m.sender == user || m.receiver == user}.sort_by {|m| m.created_at}.reverse
  end

  def average_review_score
    if reviews.count == 0
      "No reviews yet!"
    else
      sum = reviews.inject(0) {|acc, review|
        acc + review.rating
      }
      sum = sum.to_f
      "#{(sum /= reviews.count).round(1)}/5 Stars"
    end
  end

  def messages
    messages_sent + messages_received;
  end

end
