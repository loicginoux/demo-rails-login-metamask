require 'rails_helper'

RSpec.describe SessionsController do

  describe "#index" do
    context "with a logged in user" do
      xit "sends user logged in message"
    end
  end

  describe "#sign_in" do
    context "when message signature is verified" do
      xit "saves adress to session"
      xit "resets message in session"
      xit "returns login message"
      context "when user's wallet has already been used" do
        xit "does not create new user"
      end
      context "when user's wallet has never been used" do
        xit "creates a new user with the wallet address"
      end
    end

    context "when message signature cannot be verified" do
      xit "returns 400 bad request"
    end

    context "when message does not exist in session" do
      xit "returns 400 bad request"
    end
  end

  describe "#message" do
    xit "creates a nonce"
    xit "generate a SIWE message with correct parameters"
    xit "saves message to session"
    xit "returns message to be signed"
  end

  describe "#sign_out" do
    context "with a logged in user" do
      xit "remove users session"
      xit "sends user logged out message"
    end
    context "with no logged in user" do
      xit "returns 401 unauthorized"
    end
  end
end