class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
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
    post_fb(@post.artist, @post.content)
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

  def post_fb(artist, content)
    client = OAuth2::Client.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], site: 'https://graph.facebook.com', token_url: "/oauth/access_token")
    token = OAuth2::AccessToken.new(client,artist.facebook_access_token)
    token.post("#{artist.id_facebook}/feed", params: { message: content})
  end
end
