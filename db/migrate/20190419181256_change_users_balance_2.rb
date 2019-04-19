class ChangeUsersBalance2 < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :balance, :integer, :default => 1000
  end
end
