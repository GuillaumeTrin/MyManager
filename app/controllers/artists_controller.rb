class ArtistsController < ApplicationController
  def show
    @artist = Artist.find(params[:id])
    @albums = @artist.albums
    start_date = params.fetch(:start_date, Date.current).to_date
    @posts = Post.where(published_at: start_date..Date.current, artist: @artist)

    @today_posts = Post.where(published_at: Date.today..Date.today + 1.days, artist: @artist)
    if havestats(@artist)
      db_stats_array = @artist.stats.where('date > ?', DateTime.now - 7).to_a
      @stats = db_stat_extract(db_stats_array)

    else
      UpdateOneArtistJob.perform_now(@artist)
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

  def db_stat_extract(db_stats_array)
    db_stats_array.map do |stat|
      {x: stat.date, y: stat.engagement}
    end
  end
end
