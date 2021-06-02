class DashboardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def dashboard
    @artists = Artist.where(user: current_user)
    @posts = Post.where(artist: @artists)
  end

  def home
    start_date = params.fetch(:start_date, Date.current).to_date
    @posts = Post.where(published_at: start_date..Date.current)
  end
end
