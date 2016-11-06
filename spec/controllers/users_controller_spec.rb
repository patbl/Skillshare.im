require 'spec_helper'

describe UsersController do
  describe "guest access" do
    let(:user) { create(:user) }

    describe "GET #show" do
      it "redirects to the sign-in page" do
        get :show, params: { id: user }
        expect(response).not_to require_login
      end

      it "assigns the current user to @user" do
        get :show, params: { id: user }
        expect(assigns(:user)).not_to be_nil
      end
    end

    describe "GET #index" do
      it "assigns all users to @users" do
        paginated_users = double()
        expect(User).to receive(:page).with("1").and_return(paginated_users)
        allow(paginated_users).to receive_message_chain(:per, :decorate).and_return("decorated users")
        get :index, params: { page: "1" }
        expect(assigns(:users)).to eq "decorated users"
      end

      it "assigns @markers correctly" do
        user = create :user, first_name: "Joe", last_name: "Green"
        user.update(latitude: 1.0, longitude: 2.0)
        get :index
        link = ActionController::Base.helpers.link_to("Joe Green", user_path(user))
        expect(assigns(:marker_data)).to eq [{ latlng: [1.0, 2.0], popup: link, icon: "user"  }]
      end

      it "assigns the user's proposals to @proposals" do
        offer = create :offer, user: user
        get :show, params: { id: user }
        expect(assigns(:proposals)).to eq [offer]
      end
    end
  end

  describe "user access" do
    let(:user) { create(:user) }
    let(:users) { create_list(:user, 2) }

    describe "GET #edit" do
      it "allows the current user to edit her profile" do
        set_user_session(user)
        get :edit, params: { id: user }
        expect(response).to render_template :edit
        expect(assigns(:user)).to eq user
      end
    end

    describe "PATCH #update" do
      context "when changing a password" do
        let(:user) { create(:user, :has_password) }

        before do
          set_user_session(user)
        end

        context "when the passwords match" do
          it "updates the user's password" do
            expect {
              patch :update, params: { id: user.id,
                                       user: {
                                         password_identity_attributes: {
                                           password: "somethingnew",
                                           password_confirmation: "somethingnew"
                                         }
                                       }
                                     }
            }.to change { user.reload.password_identity.password_digest }
            expect(flash[:success]).to be_present
          end
        end

        context "when the passwords don't match" do
          it "doesn't update the password" do
            expect {
              patch :update, params: { id: user.id,
                                       user: {
                                         password_identity_attributes: {
                                           password: "somethingnew",
                                           password_confirmation: "somethingew"
                                         }
                                       }
                                     }
            }.not_to change { user.reload.password_identity.password_digest }
          end
        end
      end

      context "with valid attributes" do
        it "updates the user's profile" do
          user = create(:user, last_name: "Crass")
          set_user_session(user)
          patch :update, params: { user: attributes_for(:user, last_name: "Kass"), id: user }
          expect(response).to redirect_to(user)
          expect(user.reload.last_name).to eq "Kass"
          expect(flash[:success]).to be
        end
      end

      context "with invalid attributes" do
        it "doesn't update the user's profile" do
          user = create(:user, first_name: "So-and-so")
          set_user_session(user)
          patch :update, params: { user: attributes_for(:user, first_name: "Mr. Right", email: ""), id: user }
          expect(response).to render_template :edit
          expect(user.reload.first_name).to eq "So-and-so"
        end
      end

      it "doesn't allow the current user to update another user's profile" do
        good_user = create :user, location: "San Francisco"
        bad_user = create :user, location: "New York"
        set_user_session(bad_user)
        patch :update, params: { user: { location: "North Korea" }, id: good_user }
        expect(good_user.reload.location).to eq "San Francisco"
        expect(bad_user.reload.location).to eq "North Korea"
      end
    end

    describe "DELETE #destroy" do
      it "doesn't let a user delete another user's profile" do
        good_user = create :user, first_name: "Charity"
        bad_user = create :user, first_name: "Vice"
        set_user_session(bad_user)
        expect {
          delete :destroy, params: { id: good_user }
        }.to change(User, :count).by(-1)
        expect(response).to redirect_to root_path
        expect(User.where first_name: "Charity").to exist
        expect(User.where first_name: "Vice").not_to exist
      end

      it "deletes a user's offers when the user's account is deleted" do
        user = create :user
        create :offer, user: user
        set_user_session user

        expect {
          delete :destroy, params: { id: user }
        }.to change(Offer, :count).by(-1)
      end
    end
  end
end
