class MoviesController < ApplicationController
  def new
    @watched_movies = Movie.new
  end

  def create
  end

  def show
    @movie_id = Movie.find_by(id: params["format"])
    @conn = Faraday.new(
            url: 'https://www.omdbapi.com/',
            headers: {'Content-Type' => 'application/json'},)

    @movie_response = @conn.get("/") do |req|
            req.params = { 'i':  @movie_id[:imdbID] }
            req.params["apikey"] = Rails.application.credentials.dig(:omdb, :apikey)
    end
    @movie_response = JSON.parse(@movie_response.body)

    @response = @conn.get("/") do |req|
      req.params = { 's': @movie_id[:title].split(":", -1)[0] }
            req.params["apikey"] = Rails.application.credentials.dig(:omdb, :apikey)
    end
    @response2 = JSON.parse(@response.body)
  end

  def add_watched_movie
      if find_by_imdbID(movie_params[:imdbID]) == nil
        watched_movie = Movie.new(movie_params.merge!(watched: true))
        if watched_movie.save
            redirect_to watched_path, notice: "Successfully added movie to watched"
        else
            redirect_to root_path, alert: " Not okay"
        end
      else
        watched_movie= Movie.find_by(imdbID: movie_params[:imdbID])
        if watched_movie.update(watched: true)
          redirect_to watched_path, notice: "Successfully added movie to watched"
        else
          redirect_to root_path, alert: " Not okay"
        end
      end
  end

  def remove_watched_movie
      if find_by_imdbID(movie_params[:imdbID]) == nil
         redirect_to root_path, alert: " Not okay"
      else
        watched_movie= Movie.find_by(imdbID: movie_params[:imdbID])
        if watched_movie.update(watched: false)
          redirect_to watched_path, notice: "Successfully removed movie to watched"
        else
          redirect_to watched_path, alert: " Not okay"
        end
      end
  end

  def watched
    search
    if session[:user_id]
      @watched_movies = Movie.where(user_id: Current.user.id, watched: true)
    else
      redirect_to sign_in_path, notice: "You have to be logged in to view the page"
    end
  end
end
