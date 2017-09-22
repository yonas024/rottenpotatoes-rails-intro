class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if params["header"] != nil
      @movies = Movie.order(params["header"])
    else
      @movies = Movie.all
    end
    
    @all_ratings = Movie.get_ratings
    @movies = ovie
  end
  
  def ovie
    string = ""
    count = 0
    ratings = params["ratings"]
    if ratings == nil
      return @movies
    else
      ratings = ratings.keys
    end
      
    for r in ratings
      if count == 0
        string = string + "rating = " + "'" + r + "'"
        count= count + 1
      else
        string = string + " or rating = " + "'" + r + "'"
      end
    end
    
    
    return Movie.where(string)

  end

  def new
    # default: render 'new' template
  end

  def create
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

end
