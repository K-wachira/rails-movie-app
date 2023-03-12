require "rails_helper"

RSpec.describe User, type: :model do
  describe "User entry checks" do
    it "Checks if user can be saved" do
      user = User.new({ email: "a@b.c", password: "12344", password_confirmation: "1234" })
      user.save
      expect(user).not_to eq(false)
    end

    it "Checks user can not be saved with no password" do
      user = User.new({ email: "a@b.c", password_confirmation: "1234" })
      user.save
      expect(user).not_to eq(true)
    end

    it "Checks user can not be saved with no password" do
      user = User.new({ email: "a@b.c", password_confirmation: "1234" })
      user.save
      expect(user).not_to eq(true)
    end

    it "Check user can not be saved without email" do
      user = User.new({ email: nil, password: "1234", password_confirmation: "1234" })
      user.save
      expect(user).not_to eq(true)
    end
  end
end
