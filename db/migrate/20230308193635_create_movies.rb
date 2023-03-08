class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :imdbID
      t.string :poster
      t.string :title
      t.string :rating
      t.string :type
      t.boolean :liked
      t.boolean :watched
      t.boolean :to_watch

      t.timestamps
    end
  end
end
