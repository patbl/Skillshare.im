require 'spec_helper'

describe SessionsController do
  describe "GET :new" do
    it "redirects to Facebook's auth page" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "GET :create" do
    before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] }

    context "already signed in" do

    end

    context "not yet signed in" do
      it "sets the user ID in the session hash" do
        get :create
        expect(session[:user_id]).to eq User.last.id
      end

      it "lets the user know she signed in" do
        get :create
        expect(flash[:notice]).to be
      end

      context "new user" do
          it "redirects to the new-offer page" do
            get :create # creates a new user
            expect(response).to redirect_to(edit_user_path(User.last))
          end

          it "creates a new user" do
            expect { get :create }.to change(User, :count).by 1
          end
      end

      context "returning user" do
        before do
          expect(User).to receive(:new?).and_return(false)
        end

        context "with previous provider" do
          it "redirects to the home page if session[:return_to] not set", :skip do
            session[:return_to] = nil
            get :create
            expect(response).to redirect_to(root_url)
          end

          it "redirects to the previous page if there was one", :skip do
            user = create :user
            expect(User).to receive(:make_user).with(request.env["omniauth.auth"]).and_return(user)

            store_url "previous page path"
            get :create
            expect(response).to redirect_to "previous page path"
          end
        end

        context "with new provider" do

        end
      end

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
