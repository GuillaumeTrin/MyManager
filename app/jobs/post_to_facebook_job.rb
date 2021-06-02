class PostToFacebookJob < ApplicationJob
  queue_as :default

  def perform(post)
    client = OAuth2::Client.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], site: 'https://graph.facebook.com', token_url: "/oauth/access_token")
    token = OAuth2::AccessToken.new(client,post.artist.facebook_access_token)
    token.post("#{post.artist.id_facebook}/feed", params: { message: post.content})
    
  end
end
