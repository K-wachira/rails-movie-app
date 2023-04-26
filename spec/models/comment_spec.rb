require "rails_helper"

RSpec.describe Comment, type: :model do
  comment =
    Comment.create!(
      comment_text: "This is comment text text",
      movie_id: 1,
      user_id: 1
    )

  describe "Comment entry checks" do
    it "Checks if comment can be created" do
      expect(comment.comment_text).to eq("This is comment text text")
    end

    it "Checks if comment can be saved without comment_text" do
      comment.comment_text = nil
      expect(comment).to be_valid
    end

    it "Checks if comment can be saved without user id" do
      comment.movie_id = nil
      expect(comment).to_not be_valid
    end

    it "Checks if comment can be saved without movie id" do
      comment.user_id = nil
      expect(comment).to_not be_valid
    end
  end
end
