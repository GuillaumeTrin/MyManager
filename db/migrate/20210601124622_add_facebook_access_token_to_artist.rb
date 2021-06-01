class AddFacebookAccessTokenToArtist < ActiveRecord::Migration[6.0]
  def change
    add_column :artists, :facebook_access_token, :string
    add_column :users, :facebook_access_token, :string
  end
end
