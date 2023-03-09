class AddUniqueIndexToMovies < ActiveRecord::Migration[7.1]
  def change
    add_index :movies, %i[user_id imdbID], unique: true
  end
end
