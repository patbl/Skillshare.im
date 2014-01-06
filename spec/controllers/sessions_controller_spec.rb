require 'spec_helper'

describe SessionsController do
  describe "GET :new" do
    it "redirects to Facebook's auth page" do
      get :new
      expect(response).to redirect_to facebook_auth_url
    end
  end

  describe "GET :create" do
    context "already signed in" do
      before do
        @user = create :user
        @identity = create :identity
        set_user_session(@user)
        Identity.stub(:find_or_create) { @identity }
      end

      it "associates a new identity with the current user" do
        get :create
        expect(@identity.user).to eq @user
        expect(flash[:success]).to be
      end

      it "alerts the user if she tries to sign using the same provider" do
        @identity.user = @user
        get :create
        expect(flash[:alert]).to be
      end
    end

    context "not yet signed in" do
      before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] }

      it "sets the user ID in the session hash" do
        get :create
        expect(session[:user_id]).to eq User.last.id
      end

      it "lets the user know she signed in" do
        get :create
        expect(flash[:notice]).to be
      end

      it "sets Facebook data correctly" do
        get :create
        attrs = {
          email:            "joe@bloggs.com",
          name:             "Joe Bloggs",
          facebook_url:     "http://www.facebook.com/jbloggs",
          location:         "Palo Alto, California",
          oauth_token:      "ABCDEF",
          oauth_expires_at: Time.at(1321747205).to_datetime
        }
        user = User.last
        attrs.each { |k, v| expect(user.send(k)).to eq v }
      end

      context "previous user" do

        it "redirects to the previous page if there was one" do
          user = create :user
          expect(User).to receive(:create_from_auth).with(request.env["omniauth.auth"]).and_return(user)

          store_url "previous page path"
          get :create
          expect(response).to redirect_to "previous page path"
        end
      end

      context "new user" do
        it "redirects to the new-offer page" do
          get :create # creates a new user
          expect(response).to redirect_to(edit_user_path(User.last))
        end

        it "associates the new user with the identity" do
          identity = create :identity
          expect(Identity).to receive(:find_or_create).with(request.env["omniauth.auth"]).and_return(identity)
          get :create
          expect(User.last.identities).to include identity
          expect(identity.user).to eq User.last
          expect(identity.user).to be_a(User)
          expect(User.last.identities).to_not be_empty
        end

        it "creates a new user" do
          expect { get :create }.to change(User, :count).by 1
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
