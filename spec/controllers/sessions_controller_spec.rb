require 'spec_helper'

describe SessionsController do

  describe "GET :create" do
  end

  describe "GET :destroy" do
    it "should set the session user_id to nil" do
      user = build :user
      session[:user_id] = user.id
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to root_url
    end
  end

end
