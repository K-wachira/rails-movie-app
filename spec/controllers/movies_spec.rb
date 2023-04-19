require "rails_helper"

RSpec.describe MoviesController, type: :controller do
  describe "Movie entry checks" do
    let(:user){create(:user)}
    let(:movie){create(:movie, user: user)}
    it "create new movie controller" do
       expect do
         post "add_favorite_path", :params => {movie: {imdbID: "123", user_id: 1, poster: "URL", title: "Star", category: "Movies"}}
      end.to change {Movie.count}.by(1) 
    end
  end
end
