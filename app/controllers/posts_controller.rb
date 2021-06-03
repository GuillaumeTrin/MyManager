class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :schedule]
  before_action :set_artist, only: [:new, :create]

  def index
    @posts = Post.all
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.artist = @artist
    if @post.save!
      schedule_post(@post)
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

  def schedule
    if @post.published_at
      schedule_post(@post)
    end
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

  def schedule_post(post)
    PostToFacebookJob.set(wait_until: post.published_at).perform_later(post.id)
  end
end
