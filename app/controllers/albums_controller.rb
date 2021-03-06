class AlbumsController < ApplicationController
  before_action :set_album, only: [:show]
  before_action :set_artist, only: [:new, :create]

  def index
    @albums = Album.all
  end

  def show
    @posts = @album.posts
    ap "ej suis la"
    ap @posts
    if @album.posts.length <= 6
      @generated_posts = generate_post(6 - @album.posts.length)
    end

    @generated_posts.sort! {|a, b| a.published_at <=> b.published_at }

    ap @generated_posts

    @tab_active = @generated_posts.find_index { |post| post.id.nil? } || 0

    ap @tab_active
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    @album.artist = @artist
    if @album.save
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

  def generate_post(n)
    posts_array = []
    n.times do |i|
      published_at = @album.out_at - (7*(i+1))
      posts_array << Post.new(published_at: published_at, album: @album, artist: @artist)
    end
    @posts.to_a + posts_array
  end

end
