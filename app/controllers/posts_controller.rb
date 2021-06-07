class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :schedule]
  before_action :set_artist, only: [:new, :create, :edit, :destroy]

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

  def destroy
    @post.destroy
    redirect_to artist_posts_path(@artist)
  end

  def update
    @post.update(post_params)
    reschedule_post(@post)
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
    params.require(:post).permit(:title, :content, :picture, :published, :published_at)
  end

  def set_artist
    @artist = Artist.find(params[:artist_id])
  end

  def schedule_post(post)
    job_id = PostToFacebookJob.set(wait_until: post.published_at).perform_later(post.id)
    post.job_id = job_id.provider_job_id
    post.save
  end

  def reschedule_post(post)
    RescheduleFacebookJob.perform_now(post)
  end
end
