class ChangeUsersBalance < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :balance, :integer, :default => 0
  end
end
