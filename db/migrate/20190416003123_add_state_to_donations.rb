class AddStateToDonations < ActiveRecord::Migration[5.2]
  def change
    add_column :donations, :state, :boolean, :default => false
  end
end
