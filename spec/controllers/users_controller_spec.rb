require 'spec_helper'

describe UsersController do
  describe "guest access" do
    describe "GET #show" do
      let(:user) { create(:user) }

      it "redirects to the sign-in page" do
        get :show, id: user
        expect(response).to require_login
      end
    end
  end

  describe "user access" do
    let(:user) { create(:user) }
    let(:users) { create_list(:user, 2) }

    describe "GET #show" do
      it "assigns the current user to @user" do
        set_user_session(user)
        get :show, id: user
        expect(assigns(:user)).to_not be_nil
      end
    end

    describe "GET #index" do
      it "assigns all users to @users" do
        get :index
        expect(assigns(:users)).to eq users
      end
    end

    describe "GET #edit" do
      it "allows the current user to edit her profile" do
        set_user_session(user)
        get :edit, id: user
        expect(response).to render_template :edit
        expect(assigns(:user)).to eq user
      end
    end

    describe "PATCH #update" do
      it "with valid attributes" do
        user = create(:user, name: "Leon Crass")
        set_user_session(user)
        patch :update, user: attributes_for(:user, name: "Leon Kass"), id: user
        expect(response).to redirect_to(user)
        expect(user.reload.name).to eq "Leon Kass"
        expect(flash[:success]).to be
      end

      it "with invalid attributes" do
        user = create(:user, name: "So-and-so")
        set_user_session(user)
        patch :update, user: attributes_for(:user, email: ""), id: user
        expect(response).to render_template :edit
        expect(user.reload.name).to eq "So-and-so"
      end

      it "doesn't allow the current user to update another user's profile" do
        good_user = create :user, location: "San Francisco"
        bad_user = create :user, location: "New York"
        set_user_session(bad_user)
        patch :update, user: { location: "North Korea" }, id: good_user
        expect(good_user.reload.location).to eq "San Francisco"
        expect(bad_user.reload.location).to eq "North Korea"
      end
    end
  end
end
