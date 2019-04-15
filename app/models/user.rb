class User < ApplicationRecord
  has_many :donations_made, :class_name => "Donation", :foreign_key => "sender_id"
  has_many :donations_recieved, :class_name => "Donation", :foreign_key => "receiver_id"

  has_many :messages_sent, :class_name => "Message", :foreign_key => "sender_id"
  has_many :messages_recieved, :class_name => "Message", :foreign_key => "receiver_id"

  has_many :reviews_written, :class_name => "Review", :foreign_key => "writer_id"
  has_many :reviews, :class_name => "Review", :foreign_key => "user_id"
end
