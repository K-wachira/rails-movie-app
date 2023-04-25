module CommonMovieMethods
  def get_movie_by_imdbID(imdb_id)
    return Movie.find_by(imdbID: imdb_id)
  end
end
