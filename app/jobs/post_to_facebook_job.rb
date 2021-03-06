class PostToFacebookJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find_by(id: post_id)
    if post.nil?
      Sidekiq::Status.cancel self
      return
    end
    img_id = UploadImgToFb.new(post).call
    raise unless img_id.is_a? String

    client = OAuth2::Client.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], site: 'https://graph.facebook.com', token_url: "/oauth/access_token")
    token = OAuth2::AccessToken.new(client,post.artist.facebook_access_token)
    token.post("#{post.artist.id_facebook}/feed", params: { message: post.content, attached_media: [{ media_fbid: img_id }] })
  end
end
