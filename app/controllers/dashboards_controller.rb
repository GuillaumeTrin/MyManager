class DashboardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def dashboard
    @artists = Artist.where(user: current_user)
    @posts = Post.where(artist: @artists)
    @today_posts = Post.where(published_at: Date.today..Date.today + 1.days)

    stats_hash = Stat.group(:date).sum(:engagement)
    @stats = stats_hash.map do |key, value|
      { x: key.to_date, y: value }  
    end
  end

  def home
    start_date = params.fetch(:start_date, Date.current).to_date
    @posts = Post.where(published_at: start_date..Date.current)
  end
end
