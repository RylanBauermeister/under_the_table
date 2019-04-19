class Donation < ApplicationRecord
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
  belongs_to :receiver, :class_name => "User", :foreign_key => "receiver_id"

  has_many :notifications, as: :content, dependent: :destroy

  validate :check_balance

  def check_balance
    if sender.balance < amount
      errors.add(:amount, "exceeds your current balance.") and return false
    end
  end

end
