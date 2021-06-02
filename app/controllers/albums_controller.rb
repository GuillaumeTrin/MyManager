class AlbumsController < ApplicationController
  before_action :set_album, only: [:show]
  before_action :set_artist, only: [:new, :create]

  def index
    @albums = Album.all
  end

  def show
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    @album.artist = @artist
    if @album.save!
      redirect_to artist_album_path(@artist, @album)
    else
      render :new
    end
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end

  def set_artist
    @artist = Artist.find(params[:artist_id])
  end

  def album_params
    params.require(:album).permit(:name, :out_at, :artist_id)
  end
end
