require "rails_helper"

RSpec.describe Movie, type: :model do
  movie =
    Movie.create!(
      imdbID: "12imdbID",
      poster: "url",
      user_id: 1,
      title: "Movie title", 
      category: "movie", 
      liked: true,
      watched: true, 
      to_watch: true, 
    )

  describe "Movie entry checks" do
    it "Checks if movie can be created" do
      expect(movie.imdbID).to eq("12imdbID")
    end

    it "Checks if movie can be saved without title" do
      movie.title = nil
      expect(movie).to be_valid
    end

    it "Checks if movie can be saved without poster" do
      movie.poster = nil
      expect(movie).to be_valid
    end

    it "Checks if movie can be saved without user id" do
      movie.user_id = nil
      expect{movie}.to_not raise_error(ActiveRecord::RecordInvalid) 
    end
  end
end
