class CreateDonations < ActiveRecord::Migration[5.2]
  def change
    create_table :donations do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :amount
      t.string :content

      t.timestamps
    end
  end
end
