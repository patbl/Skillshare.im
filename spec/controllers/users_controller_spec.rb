require 'spec_helper'

describe UsersController do
  describe "user access" do
    let(:user) { create(:user) }
    let(:users) { create_list(:user, 2) }

    describe "GET #show" do
      it "assigns the current user to @user" do
        get :show, id: user.id
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
        session[:user_id] = user
        get :edit, user: user
        expect(response).to render_template :edit
        expect(assigns(:user)).to eq user
      end
    end

    describe "PATCH #update" do
      it "allows the current user to update her profile" do
        user = create(:user, last_name: "Crass")
        session[:user_id] = user
        patch :update, user: attributes_for(:user, last_name: "Kass"), id: user.id
        expect(response).to redirect_to(user)
        expect(User.find(user).last_name).to eq "Kass"
      end
      it "doesn't allow the current user to update another user's profile" do
        good_user = create :user
        bad_user = create :user
        session[:user_id] = bad_user
        patch :update, user: attributes_for(:user), id: good_user.id
        expect(response).to redirect_to(root_url)
      end
    end

    it "GET #destroy denies access" do
      session[:user_id] = user.id
      delete :destroy
      expect(response).to redirect_to(root_url)
    end
  end

  describe "admin access" do
    it "allows administrators to delete users" do
      unhappy_user = create :user
      session[:user_id] = create(:admin).id
      expect { delete :destroy, id: unhappy_user.id }.
        to change(User, :count).by(-1)
      expect(response).to redirect_to users_path
    end
  end
end
