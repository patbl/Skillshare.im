require 'spec_helper'

describe SessionsController do

  describe "GET :new" do
    it "redirects to the Facebook auth page" do
      get :new
      expect(response).to redirect_to facebook_auth_path
    end
  end

  describe "GET 'create'" do
  end

  describe "GET 'destroy'" do
  end

end
