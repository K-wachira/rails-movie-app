class MoviesController < ApplicationController
  def new
    @watched_movies = Movie.new
  end

  def create
  end

  def show
    @movie_id = Movie.find_by(id: params["format"])
    api_instance = OmdbApi.new
    @movie_response =
      JSON.parse(api_instance.search({ i: @movie_id[:imdbID] }).body)
    @response2 =
      JSON.parse(
        api_instance.search({ s: @movie_id[:title].split(":", -1)[0] }).body
      )
    @movie_comments = Comment.where(movie_id: params["format"])
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
      watched_movie = Movie.find_by(imdbID: movie_params[:imdbID])
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
      watched_movie = Movie.find_by(imdbID: movie_params[:imdbID])
      if watched_movie.update(watched: false)
        redirect_to watched_path,
                    notice: "Successfully removed movie to watched"
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
      redirect_to sign_in_path,
                  notice: "You have to be logged in to view the page"
    end
  end

  # Favorite Methods -----------------------------------------
  def favorite
    search
    if session[:user_id]
      @favorite_movies = Movie.where(user_id: Current.user.id, liked: true)
    else
      redirect_to sign_in_path,
                  notice: "You have to be logged in to view the page"
    end
  end

  def add_favorite_movie
    if find_by_imdbID(movie_params[:imdbID]) == nil
      favorite_movie =
        Movie.new(movie_params.merge!(liked: true, to_watch: false))
      if favorite_movie.save
        redirect_to favorite_path, notice: "Successfully liked movie"
      else
        redirect_to root_path, alert: " Not okay"
      end
    else
      favorite_movie = Movie.find_by(imdbID: movie_params[:imdbID])
      if favorite_movie.update(liked: true, to_watch: false)
        redirect_to favorite_path, notice: "Successfully liked movie"
      else
        redirect_to root_path, alert: " Not okay"
      end
    end
  end

  def remove_favorite_movie
    if find_by_imdbID(movie_params[:imdbID]) == nil
      redirect_to root_path, alert: " Not okay"
    else
      favorite_movie = Movie.find_by(imdbID: movie_params[:imdbID])
      if favorite_movie.update(liked: false)
        redirect_to favorite_path, notice: "Successfully unliked movie"
      else
        redirect_to root_path, alert: " Not okay"
      end
    end
  end

  # Watch list movie Methods -------------------------------
  def add_watch_movie
    if find_by_imdbID(movie_params[:imdbID]) == nil
      watch_list_movie = Movie.new(movie_params.merge!(to_watch: true))
      if watch_list_movie.save
        redirect_to to_watch_path,
                    notice: "Successfully added movie to watch list"
      else
        redirect_to root_path, alert: " Not okay"
      end
    else
      watch_list_movie = Movie.find_by(imdbID: movie_params[:imdbID])
      if watch_list_movie.update(to_watch: true)
        redirect_to to_watch_path,
                    notice: "Successfully added movie to watch list"
      else
        redirect_to root_path, alert: " Not okay"
      end
    end
  end

  def remove_watch_movie
    if find_by_imdbID(movie_params[:imdbID]) == nil
      redirect_to root_path, alert: " Not okay"
    else
      watch_list_movie = Movie.find_by(imdbID: movie_params[:imdbID])
      if watch_list_movie.update(to_watch: false)
        redirect_to to_watch_path,
                    notice: "Successfully removed movie to watch list"
      else
        redirect_to root_path, alert: " Not okay"
      end
    end
  end

  def watch_list
    search
    if session[:user_id]
      @watch_list_movies = Movie.where(user_id: Current.user.id, to_watch: true)
    else
      redirect_to sign_in_path,
                  notice: "You have to be logged in to view the page"
    end
  end

  private

  def search
    puts "It does hit the movie controller"
    if params[:search]
      redirect_to url_for(
                    controller: :searchs,
                    action: :search,
                    search: params[:search],
                    page: 0
                  )
    end
  end

  def find_by_imdbID(imdbID)
    return Movie.find_by(imdbID: imdbID)
  end

  def find_by_user_byID(user_id)
    return User.find_by(user_id: user_id)
  end

  def movie_params
    @params = params.as_json["movie"].as_json.keys[0].dup
    @params.gsub! "=>", ":" if @params.include? "=>"
    obj = ActiveSupport::JSON.decode(@params)
    {
      imdbID: obj["imdbID"],
      user_id: Current.user.id,
      poster: obj["Poster"] || obj["poster"],
      title: obj["Title"] || obj["title"],
      category: obj["Type"] || obj["type"]
    }
  end
end
