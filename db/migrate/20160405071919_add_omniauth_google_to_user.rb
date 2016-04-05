class AddOmniauthGoogleToUser < ActiveRecord::Migration
  def change
    add_column :users, :google_uid, :string
    add_column :users, :google_token, :string

    add_index :users, :google_uid
  end
end
