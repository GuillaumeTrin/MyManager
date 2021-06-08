require "open-uri"
class UpdateOneUserFb < BaseService

  def initialize(user)
    @user = user
  end

  def call
    client = OAuth2::Client.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], site: 'https://graph.facebook.com', token_url: "/oauth/access_token")
    token = OAuth2::AccessToken.new(client, @user.facebook_access_token)
    response = token.get("/me?fields=picture")
    json = JSON.parse(response.body)
    avatar_url = json["picture"]["data"]["url"]
    avatar_file = URI.open(avatar_url)
    @user.avatar.attach(io: avatar_file, filename: "#{@user.first_name}avatar.png", content_type: 'image/png')
    @user.save
  end
end
