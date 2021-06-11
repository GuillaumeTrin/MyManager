class UpdateOneArtist < BaseService

  def initialize(artist)
    @artist = artist
  end

  def call
    return if havestats(@artist)

    array_json = get_fb_stats(@artist)
    fb_stat_extract(array_json, @artist)
  end

  def havestats(artist)
    latest_date = artist.stats.order('date desc').limit(1).to_a[0]
    return false if latest_date.nil?

    return latest_date.date > Date.today
  end

  def get_fb_stats(artist)
    client = OAuth2::Client.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], site: 'https://graph.facebook.com', token_url: "/oauth/access_token")
    token = OAuth2::AccessToken.new(client,artist.facebook_access_token)
    now = Date.today
    a_week_ago = (now - 8)
    response = token.get("#{artist.id_facebook}/insights/page_post_engagements/?since=#{a_week_ago}")
    json = JSON.parse(response.body)
    json["data"][1]["values"]
  end

  def fb_stat_extract(array,artist)
    array.map do |json|
      stat = Stat.new(date:json["end_time"].to_date,engagement:json["value"])
      stat.artist = artist
      stat.save
    end
  end
end
