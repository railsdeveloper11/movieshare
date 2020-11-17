class ReviewsController < ApplicationController
  before_action :find_user, only: [:edit, :update, :destroy]
  before_action :check_movie_url, only: :create

  def index
    @reviews = current_user.reviews
  end

  def new
    @review = current_user.reviews.new
  end

  def edit
  end

  def create
    if check_movie_url
      uri    = URI.parse(@movieId) 
      params = CGI.parse(uri.query)
      @movie = Movie.find_or_initialize_by(movie_url: params["v"][0])
      if @movie.save
        @review = current_user.reviews.new(require_params)
        if @review.save
          flash.alert = "Reviwed Succesfuly"
          redirect_to reviews_path
        else
          render_error_message @review.errors.full_messages
        end
      else
        render_error_message @movie.errors.full_messages
      end
    else
      render_error_message "Please enter valid URL"
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
    params.require(:review).permit(:rating, :description).merge!(movie_id: @movie.id)
  end

  def check_movie_url
    @movieId = (params[:review][:movie][:movie_url])
    pattern = Regexp.new(/(https?\:\/\/)?(www\.)?(youtube\.com)?(\/watch\?v=[A-Za-z0-9-_]{11})/)
    pattern.match?(@movieId)
  end

  def render_error_message(message)
    flash.alert = message
    @review = current_user.reviews.new
    render 'new'
  end
end