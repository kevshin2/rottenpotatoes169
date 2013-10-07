class MoviesController < ApplicationController

  

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    
  end

  def index
    @all_ratings = Movie.rating
    @sorts = params[:sorting] || session[:sorting] || {}
    if @sorts == "title"
      order = {:order => 'title'}
    elsif @sorts == "release_date"
      order = {:order => 'release_date'}
    end
    @checked = params[:ratings] || session[:ratings] 
    
    if params[:sorting] != session[:sorting]
      session[:sorting] = @sorts
      redirect_to :sorting => @sorts, :ratings => @checked and return
    end

    if params[:ratings] != session[:ratings] and @checked != {}
      session[:sorting] = @sorts
      session[:ratings] = @checked
      redirect_to :sorting => @sorts, :ratings => @checked and return
    end
    
    @movies = Movie.find_all_by_rating(@checked.keys, order)
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
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
