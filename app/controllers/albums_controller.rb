class AlbumsController < ApplicationController
  before_action :set_album, only: [:show]

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
    if @album.save
      redirect_to artist_path(@album.artist)
    else
      render :new
    end
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:name, :out_at, :artist_id)
  end
end
