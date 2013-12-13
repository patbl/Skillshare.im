require 'spec_helper'

describe SessionsController do
  describe "GET :new" do
    it "redirects to Facebook's auth page" do
      get :new
      expect(response).to redirect_to "/auth/facebook"
    end
  end

  describe "GET :create" do
    before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] }

    it "redirects to the home page if session[:return_to] not set", :skip do
      session[:return_to] = nil
      get :create
      expect(response).to redirect_to(root_url)
    end

    it "redirects to the previous page if there was one and the user isn't new" do
      user = create :user
      expect(user).to receive(:new?).and_return(false)
      expect(User).to receive(:from_omniauth).with(request.env["omniauth.auth"]).and_return(user)

      store_url "previous page path"
      get :create
      expect(response).to redirect_to "previous page path"
    end

    it "redirects to the new-proposal page if the user is new" do
      get :create # creates a new user
      expect(response).to redirect_to(edit_user_path(User.last))
    end

    it "creates a new user" do
      expect { get :create }.to change(User, :count).by 1
    end

    it "sets the user ID in the session hash" do
      get :create
      expect(session[:user_id]).to eq User.last.id
    end

    it "lets the user know she signed in" do
      get :create
      expect(flash[:notice]).to be
    end
  end

  describe "GET :failure" do
    before { get :failure }

    it "redirects to the home page" do
      expect(response).to redirect_to(root_url)
    end

    it "displays an error message" do
      expect(flash[:error]).to be
    end
  end

  describe "DELETE :destroy" do
    it "should set the session user_id to nil" do
      user = build_stubbed(:user)
      set_user_session(user)
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the home page" do
      delete :destroy
      expect(response).to redirect_to root_url
    end

    it "displays a message" do
      delete :destroy
      expect(flash[:notice]).to be
    end
  end
end
