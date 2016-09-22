require 'spec_helper'

describe SessionsController do
  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "already signed in" do
      before do
        @user = create :user
        @identity = create :identity
        set_user_session(@user)
        allow(Identity).to receive(:find_or_create).and_return(@identity)
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
          first_name:       "Joe",
          last_name:        "Bloggs",
          facebook_url:     "http://www.facebook.com/jbloggs",
          location:         "Palo Alto, California",
          oauth_token:      "ABCDEF",
          oauth_expires_at: Time.at(1321747205).to_datetime
        }
        user = User.last
        attrs.each { |k, v| expect(user.send(k)).to eq v }
      end

      context "previous user" do
        context "with new identity" do
          before do
            email = OmniAuth.config.mock_auth[:facebook][:info][:email]
            @user = create(:user, email: email)
            @persona_identity = create(:identity, provider: 'browser_id', user: @user)
          end

          it "associates the new identity with the old user account" do
            get :create

            expect(@user.identities.count).to eq 2
            expect(Identity.first.provider).to eq 'browser_id'
            expect(Identity.last.provider).to eq 'facebook'
            expect(Identity.first.user).to eq Identity.last.user
          end
        end

        it "redirects to the previous page if there was one" do
          user = create :user
          expect(User).to receive(:find_or_create_from_auth!).and_return(user)

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
          expect(Identity).to receive(:find_or_create).and_return(identity)
          get :create
          expect(User.last.identities).to include identity
          expect(identity.user).to eq User.last
          expect(identity.user).to be_a(User)
          expect(User.last.identities).not_to be_empty
        end

        it "creates a new user" do
          expect { get :create }.to change(User, :count).by 1
          expect(flash[:notice]).to be
          expect(flash.count).to eq 1
        end
      end
    end
  end

  describe "#create_with_password" do
    context "when an account with that email address exists" do
      let!(:user) { create(:user, email: "shakira@gmail.com") }
      let!(:identity) { create(:password_identity, password: "hunter2", user: user) }

      context "when the password is correct" do
        let(:params) { { session: { email: "shakira@gmail.com", password: "hunter2" } } }

        it "signs you in" do
          post :create_with_password, params: params

          expect(session[:user_id]).to eq user.id
          expect(response).to redirect_to(root_url)
        end
      end

      context "when the password is wrong" do
        let(:params) { { session: { email: "shakira@gmail.com", password: "hunter3" } } }

        it "re-renders the page" do
          post :create_with_password, params: params

          expect(session[:user_id]).to be nil
          expect(response).to render_template(:new)
        end
      end
    end

    context "when the email address doesn't exist" do
      it "re-renders the page" do
        post :create_with_password, params: { session: { email: "shakira@gmail.com", password: "hunter2" } }

        expect(session[:user_id]).to be nil
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#failure" do
    before { get :failure }

    it "redirects to the home page" do
      expect(response).to redirect_to(root_url)
    end

    it "displays an error message" do
      expect(flash[:error]).to be
    end
  end

  describe "#destroy" do
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
