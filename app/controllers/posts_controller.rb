class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :destroy, :update, :schedule]
  before_action :set_artist, only: [:new, :create, :edit]

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
      if previous_controller == "posts"
        redirect_to artist_path(@post.artist), notice: "You've just created a new post"
      else
        redirect_to artist_album_path(@artist, params[:post][:album_id])
      end
    else
      render :new
    end
  end

  def edit
    @from = params["from"].presence
  end

  def destroy
    @post.destroy
    redirect_back(fallback_location: root_path)
  end

  def update
    @post.update!(post_params)
    reschedule_post(@post)

    if previous_controller == "posts"
      if params.dig('post', 'from') == "dashboard"
        redirect_to root_path
      else
        redirect_to artist_path(@post.artist)
      end
    else
      redirect_to artist_album_path(@post.artist, @post.album)
    end
  end


  def delete
    @post = Post.destroy
  end

  # def delete
  #   @post = Post.destroy
  # end


  def schedule
    if @post.published_at
      schedule_post(@post)
    end
  end

  private

  def previous_controller
    Rails.application.routes.recognize_path(request.referrer)[:controller]
  end


  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :picture, :published, :published_at, :album_id)
  end

  def set_artist
    @artist = Artist.find(params[:artist_id])
  end

  def schedule_post(post)
    job_id = PostToFacebookJob.set(wait_until: post.published_at - 2.hours).perform_later(post.id)
    post.job_id = job_id.provider_job_id
    post.save
  end

  def reschedule_post(post)
    RescheduleFacebookJob.perform_now(post)
  end
end
