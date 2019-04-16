class AddActiveToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :active, :boolean, :default => true
  end
end
