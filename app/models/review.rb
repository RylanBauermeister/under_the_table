class Review < ApplicationRecord
  belongs_to :writer, :class_name => "User", :foreign_key => "writer_id"
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  has_many :notifications, as: :content


  # def writer
  #   writer = User.new(username: "[DELETED]") if !writer
  # end
end
