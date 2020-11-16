class ReviewsController < ApplicationController
  before_action :find_user, only: [:edit, :update, :destroy]
  def index
    @reviews = current_user.movies
  end

  def new
    @review = current_user.reviews.new
  end

  def edit
  end

  def create
    movie_id = find_movie(params[:review][:movie][:movie_url])
    if movie_id 
      @review = current_user.reviews.new(require_params)
    end
  end

  private

  def find_user
    @review = current_user.movies.find(params[:id])
  end

  def require_params
    params.require(:review).permit(:movie_url, :rating, :description)
  end

  def find_movie(url_id)
    movie = Movie.all
    movie.each do |val|
      if val.movie_url == url_id
        return val.id
      end
    end
    movie = Movie.new(movie_url: url_id)
    if movie.save
      return movie.id
    end
  end

end