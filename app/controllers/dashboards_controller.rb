class DashboardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def dashboard
    @artists = Artist.where(user: current_user)
    @posts = current_user.posts
    @albums = current_user.albums
    @today_posts = @posts.where(published_at: Date.today..Date.today + 1.days)
    @stats = all_artist_stats
    @array_artists = @artists.map(&:id)
    @hide_navbar = true if current_user.facebook_access_token.blank?
    # @all_publishable = @posts.current_week.all?(&:publishable?)
  end

  def home
    start_date = params.fetch(:start_date, Date.current).to_date
    @posts = Post.where(published_at: start_date..Date.current)
  end

  private

  def all_artist_stats
    stats_hash = Stat.where('date > ?', DateTime.now - 8).order(date: :asc).group(:date).sum(:engagement)
    stats_hash.map do |key, value|
      { x: key.to_date, y: value }
    end
  end
end
