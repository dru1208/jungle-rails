require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validates" do
    before do
      @a_user = User.new(first_name: "dave", last_name: "bro", email: "dave@gmail.com", password: "dave", password_confirmation: "dave")
    end

    it "can save with all valid fields" do
      expect(@a_user).to be_valid
      expect(@a_user.save).to eq(true)
    end

    it "cannot save without a valid first name" do
      @a_user.first_name = nil
      expect(@a_user).to_not be_valid
      @a_user.save
      expect(@a_user.errors.full_messages).to include "First name can't be blank"
    end

    it "cannot save without a valid last name" do
      @a_user.last_name = nil
      expect(@a_user).to_not be_valid
      @a_user.save
      expect(@a_user.errors.full_messages).to include "Last name can't be blank"
    end

    it "cannot save without an email" do
      @a_user.email = nil
      expect(@a_user).to_not be_valid
      @a_user.save
      expect(@a_user.errors.full_messages).to include "Email can't be blank"
    end

    it "cannot save if email is already in system" do
      @a_second_user = User.create(first_name: "dave1", last_name: "real-bro", email: "dave@gmail.com", password: "dave", password_confirmation: "dave")
      @a_user.save
      expect(@a_user.errors.full_messages).to include "Email has already been taken"
    end

    it "cannot save with a password that is too short" do
      @a_user.password = "a"
      @a_user.password_confirmation = "a"
      expect(@a_user).to_not be_valid
      @a_user.save
      expect(@a_user.errors.full_messages).to include "Password is too short (minimum is 2 characters)"
    end

    it "cannot save if password does not match confirmation" do
      @a_user.password = "bro"
      expect(@a_user).to_not be_valid
      @a_user.save
      expect(@a_user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

  end

  describe ".authenticate_with_credentials" do
    before do
      @user = User.create(first_name: "dave", last_name: "bro", email: "dave@gmail.com", password: "dave", password_confirmation: "dave")
    end

    it "will log on with proper credentials" do
      @correct_user = User.authenticate_with_credentials("dave@gmail.com", "dave")
      expect(@correct_user).to eq(@user)
    end

    it "will not log on with the wrong email" do
      @incorrect_user = User.authenticate_with_credentials("nah@gmail.com", "dave")
      expect(@incorrect_user).to eq(nil)
    end

    it "will not log on with the wrong password" do
      @incorrect_user = User.authenticate_with_credentials('dave@gmail.com', "nah")
      expect(@incorrect_user).to eq(nil)
    end

    it "will log on with white spaces before email" do
      @correct_user = User.authenticate_with_credentials('     dave@gmail.com', "dave")
      expect(@correct_user).to eq(@user)
    end

    it "will log on with wrong cases for email" do
      @correct_user = User.authenticate_with_credentials('dAvE@gMaIL.coM', "dave")
      expect(@correct_user).to eq(@user)
    end

  end
end
