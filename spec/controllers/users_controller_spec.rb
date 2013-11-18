require 'spec_helper'

describe UsersController do
  describe "user access" do
    let(:user) { create(:user) }
    let(:users) { create_list(:user, 2) }

    describe "GET #show" do
      it "assigns the current user to @user" do
        session[:user_id] = create :user
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
        session[:user_id] = user
        get :edit, id: user
        expect(response).to render_template :edit
        expect(assigns(:user)).to eq user
      end
    end

    describe "PATCH #update" do
      it "with valid attributes" do
        user = create(:user, name: "Leon Crass")
        session[:user_id] = user
        patch :update, user: attributes_for(:user, name: "Leon Kass"), id: user
        expect(response).to redirect_to(user)
        expect(User.find(user).name).to eq "Leon Kass"
      end

      it "with invalid attributes" do
        user = create(:user, name: "So-and-so")
        session[:user_id] = user
        patch :update, user: attributes_for(:user, email: ""), id: user
        expect(response).to render_template :edit
        expect(user.reload.name).to eq "So-and-so"
      end

      it "doesn't update when Cancel is clicked" do
        session[:return_to] = "previous page"
        a_user = create :user, email: "foo@gmail.com"
        session[:user_id] = a_user
        patch :update, user: attributes_for(:user, email: ""), id: a_user, cancel: true
        expect(a_user.reload.email).to eq "foo@gmail.com"
        expect(response).to redirect_to "previous page"
      end

      it "doesn't allow the current user to update another user's profile" do
        good_user = create :user
        bad_user = create :user
        session[:user_id] = bad_user
        patch :update, user: attributes_for(:user), id: good_user
        expect(response).to redirect_to(root_url)
      end
    end

    it "GET #destroy denies access" do
      session[:user_id] = user
      delete :destroy, id: 1
      expect(response).to redirect_to(root_url)
    end

  end

  describe "admin access" do
    it "allows administrators to delete users" do
      unhappy_user = create :user
      session[:user_id] = create(:admin)
      expect { delete :destroy, id: unhappy_user }
        .to change(User, :count).by(-1)
      expect(response).to redirect_to users_path
    end
  end
end
