class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :profession
      t.string :location
      t.integer :balance
      t.string :profile_picture_url

      t.timestamps
    end
  end
end
