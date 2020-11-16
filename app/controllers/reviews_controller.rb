class ReviewsController < ApplicationController
  before_action :find_user, only: [:edit, :update, :destroy]
  def index
    @reviews = current_user.reviews
  end

  def new
    @review = current_user.reviews.new
  end

  def edit
  end

  def create
    movieId = find_movie(params[:review][:movie][:movie_url])
    if movieId 
      @review = current_user.reviews.new(require_params)
      @review.movie_id = movieId
      if @review.save
        flash.alert = "Reviwed Succesfuly"
        redirect_to reviews_path
      else
        render 'new'
      end
    end
  end

  def update
    if @review.update(require_params)
      redirect_to reviews_path
    else
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    redirect_to reviews_path
  end

  private

  def find_user
    @review = current_user.reviews.find(params[:id])
  end

  def require_params
    params.require(:review).permit(:movie_url, :rating, :description)
  end

  def find_movie(url_id)
    movie = Movie.all
    url_id = url_id[-11..-1]
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