ap "je usis la"


client = OAuth2::Client.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], site: 'https://graph.facebook.com', token_url: "/oauth/access_token")

artist = Artist.find(19)

token = OAuth2::AccessToken.new(client,artist.facebook_access_token)

ap client
ap artist
ap token
ap "#{artist.id_facebook}/feed"

token.post("#{artist.id_facebook}/feed", params: { message: "couco"})
