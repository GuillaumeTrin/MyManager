class FacebookController < ApplicationController

  def connect
    ap "ascope"
    ap %W[read_insights
                  pages_show_list
                  pages_manage_posts
                  pages_read_engagement].join(',')
    client = OAuth2::Client.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], site: 'https://graph.facebook.com', token_url: "/oauth/access_token")
    url = client.auth_code.authorize_url(redirect_uri: 'http://localhost:3000/oauth2/callback',
        scope: %W[read_insights
                  pages_show_list
                  pages_manage_posts
                  pages_read_engagement].join(','))

    redirect_to url
  end

  def callback
    client = OAuth2::Client.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], site: 'https://graph.facebook.com', token_url: "/oauth/access_token")
    auth_code = params[:code]
    token = client.auth_code.get_token(auth_code, redirect_uri: 'http://localhost:3000/oauth2/callback', headers: {'Authorization' => 'Basic some_password'})
    current_user.facebook_access_token = token
    current_user.save
    response = token.get('/me/accounts')
    json = JSON.parse(response.body)
    artists = json["data"]
    create_artists(artists, token)
    redirect_to dashboard_path
  end

  def disconnect
    current_user.update(facebook_access_token: nil)
    redirect_to dashboard_path
  end

  private

  def get_picture(token, page_id)
    response = token.get("/#{page_id}/picture?redirect=0&height=400&width=400")
    picture = JSON.parse(response.body)
    picture["data"]["url"]
  end

  def create_artists(artists, token)
    Artist.destroy_all # todo remove this line
    artists.each do |artist|
      name = artist["name"]
      id = artist["id"]
      picture = get_picture(token, id)
      access_token = artist["access_token"]
      artist = Artist.new(name: name, id_facebook: id, picture: picture, facebook_access_token: access_token)
      artist.user = current_user
      artist.save!
    end
  end
end
