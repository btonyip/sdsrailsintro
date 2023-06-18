class MoviesController < ApplicationController

  def show
    Rails.logger.info(params.inspect)
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #Rails.logger.info(params.inspect) <- for debugging check log/development.log
    Rails.logger.info(params.inspect)
    if params[:home] == nil
      params[:ratings] = session[:ratings]
      params[:sorting] = session[:sorting]
    end
    @all_ratings = Movie.all_ratings #define all ratings
    @ratings_to_show_hash = Movie.ratings_to_show_hash(params[:ratings] || @all_ratings) 
    @column_sorting = Movie.column_sort(params[:sorting])
    @movies = Movie.sort_with_ratings(@ratings_to_show_hash, @column_sorting)
    session[:ratings] = params[:ratings] 
    session[:sorting] = params[:sorting] 
  end

  def new
    # default: render 'new' template
  end

  def create
    Rails.logger.info(params.inspect)
    session[:ratings] = params[:ratings]
    session[:sorting] = params[:sorting]    
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end


  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
