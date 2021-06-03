class ArtistsController < ApplicationController
  def show
    @artist = Artist.find(params[:id])
    start_date = params.fetch(:start_date, Date.current).to_date
    @posts = Post.where(published_at: start_date..Date.current, artist: @artist)
    stats_json = getstats(@artist)
    @stats = statextract(stats_json)
  end

  def index
    @artists = Artist.all
  end

  private

  def getstats(artist)
    client = OAuth2::Client.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], site: 'https://graph.facebook.com', token_url: "/oauth/access_token")
    token = OAuth2::AccessToken.new(client,artist.facebook_access_token)
    response = token.get("#{artist.id_facebook}/insights/page_post_engagements")
    json = JSON.parse(response.body)
    json["data"][1]["values"]
  end


   def statextract(json)
     result = json.map do |value|
     [value["value"],value["end_time"]]
     end
   end
end
