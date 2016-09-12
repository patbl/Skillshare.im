require 'spec_helper'

describe ApplicationController, type: :controller do
  controller do
    def index
      @current_user = current_user
      render body: "hey there"
    end
  end

  let!(:user) { create(:user) }

  describe "#current_user" do
    context "with user logged in" do
      before do
        session[:user_id] = user.id
        get :index
      end

      it "assigns the current user" do
        expect(assigns(:current_user)).to eq user
      end
    end

    context "without user logged in" do
      it "doesn't assign a current user" do
        get :index
        expect(assigns(:current_user)).to eq @current_user
      end
    end

    context "user doesn't exist" do
      before do
        session[:user_id] = "foo"
        get :index
      end

      it "doesn't assign a current user" do
        expect(assigns(:current_user)).to be nil
      end

      it "deletes user_id from session" do
        expect(session[:user_id]).to be nil
      end
    end
  end
end
