class ArtistsController < ApplicationController
  def show
    @artist = Artist.find(params[:id])
    start_date = params.fetch(:start_date, Date.current).to_date
    @posts = Post.where(published_at: start_date..Date.current, artist: @artist)
  end

  def index
    @artists = Artist.all
  end

end
