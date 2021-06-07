class ArtistsController < ApplicationController
  def show
    @artist = Artist.find(params[:id])
    start_date = params.fetch(:start_date, Date.current).to_date
    @posts = Post.where(published_at: start_date..Date.current, artist: @artist)

    @today_posts = Post.where(published_at: Date.today..Date.today + 1.days, artist: @artist)
    if havestats(@artist)
      db_stats_array = @artist.stats.where('date > ?', DateTime.now - 7).to_a
      @stats = db_stat_extract(db_stats_array)

    else
      array_json = get_fb_stats(@artist)
      @stats = fb_stat_extract(array_json, @artist)
    end
  end

  def index
    @artists = Artist.all
  end

  private

  def havestats(artist)
    latest_date = artist.stats.order('date desc').limit(1).to_a[0]
    return false if latest_date.nil?

    return Date.today > latest_date.date
  end

  def get_fb_stats(artist)
    client = OAuth2::Client.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], site: 'https://graph.facebook.com', token_url: "/oauth/access_token")
    token = OAuth2::AccessToken.new(client,artist.facebook_access_token)
    now = Date.today
    a_week_ago = (now - 7)
    response = token.get("#{artist.id_facebook}/insights/page_post_engagements/?since=#{a_week_ago}")
    json = JSON.parse(response.body)
    json["data"][1]["values"]
  end

  def fb_stat_extract(array,artist)
    array.map do |json|
      stat = Stat.new(date:json["end_time"].to_date,engagement:json["value"])
      stat.artist = artist
      stat.save!
      { x: json["end_time"].to_date, y: json["value"] }
    end
  end

  def db_stat_extract(db_stats_array)
    db_stats_array.map do |stat|
      {x: stat.date, y: stat.engagement}
    end
  end
end
