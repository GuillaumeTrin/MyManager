class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  # def home
  #   start_date = params.fetch(:start_date, Date.current).to_date
  #   @posts = Post.where(published_at: start_date..Date.current)
  # end
end
