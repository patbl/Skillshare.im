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
      before do
        set_user_session(user)
      end

      it "assigns the current user to @user" do
        get :show, id: user
        expect(assigns(:user)).not_to be_nil
      end

      it "assigns the user's proposals to @proposals" do
        offer = create :offer, user: user
        get :show, id: user
        expect(assigns(:proposals)).to eq [offer]
      end
    end

    describe "GET #index" do
      it "assigns all users to @users" do
        paginated_users = double()
        expect(User).to receive(:page).with("1").and_return(paginated_users)
        allow(paginated_users).to receive_message_chain(:per, :decorate).and_return("decorated users")
        get :index, page: "1"
        expect(assigns(:users)).to eq "decorated users"
      end

      it "assigns @markers correctly" do
        user = create :user, name: "Joe"
        user.update(latitude: 1.0, longitude: 2.0)
        get :index
        link = ActionController::Base.helpers.link_to("Joe", user_path(user))
        expect(assigns(:marker_data)).to eq [{ latlng: [1.0, 2.0], popup: link, icon: "user"  }]
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
      context "with valid attributes" do
        it "updates the user's profile" do
          user = create(:user, name: "Leon Crass")
          set_user_session(user)
          patch :update, user: attributes_for(:user, name: "Leon Kass"), id: user
          expect(response).to redirect_to(user)
          expect(user.reload.name).to eq "Leon Kass"
          expect(flash[:success]).to be
        end
      end

      context "with invalid attributes" do
        it "doesn't update the user's profile" do
          user = create(:user, name: "So-and-so")
          set_user_session(user)
          patch :update, user: attributes_for(:user, email: ""), id: user
          expect(response).to render_template :edit
          expect(user.reload.name).to eq "So-and-so"
        end
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

    describe "DELETE #destroy" do
      it "doesn't let a user delete another user's profile" do
        good_user = create :user, name: "Charity"
        bad_user = create :user, location: "Vice"
        set_user_session(bad_user)
        expect { delete :destroy, id: good_user }.to change(User, :count).by(-1)
        expect(response).to redirect_to root_path
        expect(User.where name: "Charity").to exist
        expect(User.where name: "Vice").not_to exist
      end

      it "deletes a user's offers when the user's account is deleted" do
        user = create :user
        create :offer, user: user
        set_user_session user

        expect { delete :destroy, id: user }.to change(Offer, :count).by(-1)
      end
    end
  end
end
