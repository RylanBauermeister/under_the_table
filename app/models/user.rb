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

  def new_donation(receiver:, amount:)
    donation = Donation.create(sender: self, receiver: receiver, amount: amount)
    notification = Notification.create(user: receiver, content: donation)
    donation
  end

  def new_message(receiver:, title:, content:)
    message = Message.create(sender: self, receiver: receiver, title: title, content: content)
    notification = Notification.create(user: receiver, content: message)
    message
  end

  def new_review(user:, rating:, content:)
    review = Review.create(writer: self, user: user, rating: rating, content: content)
    notification = Notification.create(user: receiver, content: review)
    review
  end
end
