class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_artist, only: [:new]

  def index
    @posts = Post.all
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save!
      redirect_to artist_path(@post.artist), notice: "You've just created a new post"
    else
      render :new
    end
  end

  def edit; end

  def update
    @post.update(post_params)
    redirect_to artist_path(@post.artist)
  end

  def delete
    @post = Post.destroy
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :image, :published, :published_at)
  end

  def set_artist
    @artist = Artist.find(params[:artist_id])
  end
end
