class UploadImgToFb < BaseService
  def initialize(post)
    @post = post
  end

  def call
    img_url = Cloudinary::Utils.cloudinary_url(@post.picture.key)
    client = OAuth2::Client.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], site: 'https://graph.facebook.com', token_url: "/oauth/access_token")
    token = OAuth2::AccessToken.new(client,@post.artist.facebook_access_token)
    response = token.post("#{@post.artist.id_facebook}/photos", params: { url: img_url, published: "false" })
    image_id = JSON.parse(response.body)["id"]
    return image_id
  end
end
