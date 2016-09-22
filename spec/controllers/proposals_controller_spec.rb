# == Schema Information
#
# Table name: proposals
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  type        :string
#
# Indexes
#
#  index_proposals_on_user_id  (user_id)
#

require 'spec_helper'

describe ProposalsController do
  shared_examples "public access to offers" do
    before do
      @wanted = create(:wanted, category_list: "tutoring")
    end

    describe "#index" do
      describe "when unfiltered" do
        it "gets all the offers when unfiltered" do

          get :index, params: { type: "Wanted" }
          expect(assigns(:proposals)).to match_array Wanted.order(created_at: :desc)
        end
      end

      describe "when filtered" do
        it "doesn't show anything if there's nothing" do
          get :index, params: { category: "lodging", type: "Wanted" }
          expect(response).to render_template(:index)
          expect(assigns(:proposals)).to be_empty
        end

        it "shows offers from the relevant category if they exist" do
          get :index, params: { category: "tutoring", type: "Wanted" }
          expect(assigns(:proposals)).to match_array [@wanted]
        end
      end

      it "paginates offers" do
        filtered_offers = double
        expect(Proposal).to receive(:filter_by_tag).and_return(filtered_offers)
        paginated_offers = double
        expect(filtered_offers).to receive(:page).with("2").and_return paginated_offers
        allow(paginated_offers).to receive_message_chain(:per, :decorate).and_return("decorated offers")

        get :index, params: { page: "2", type: "Offer" }

        expect(assigns(:proposals)).to eq "decorated offers"
      end

      it "renders the Atom feed" do
        get :index, params: { format: "atom", type: "Proposal" }
        expect(response).to render_template(:index)
        expect(response.content_type).to eq("application/atom+xml")
        expect(assigns(:updated_at)).to be_same_second_as @wanted.updated_at
      end
    end

    describe "#home" do
      it "assigns offers" do
        get :home
        expect(assigns(:offers)).to be_empty
        expect(assigns(:wanteds)).to match_array [@wanted]
      end
    end
  end

  describe "user" do
    it_behaves_like "public access to offers"

    context "changing stuff" do
      before do
        @wanted = create(:wanted, category_list: "lodging", title: "qqqqqq")
        @user = @wanted.user
        set_user_session(@user)
      end

      describe "GET #new" do
        it "assigns a new wanted to @wanted" do
          get :new, params: { user_id: @user, type: "Wanted" }
          expect(assigns(:proposal)).to be_a_new(Wanted)
          expect(assigns(:user)).to eq @user
        end
      end

      describe "GET #edit" do
        it "assigns the requested wanted to @proposal" do
          get :edit, params: { id: @wanted, type: "Wanted" }

          expect(assigns(:proposal)).to eq @wanted
        end

        it "assings the user to @user" do
          get :edit, params: { id: @wanted, type: "Wanted" }

          expect(assigns(:user)).to eq @user
        end
      end

      describe "POST #create" do
        context "with valid attributes" do
          it "saves the new wanted in the database" do
            expect {
              post :create, params: { wanted: attributes_for(:wanted), user_id: @user, type: "Wanted" }
            }.to change(Wanted, :count).by(1)
            expect(response).to redirect_to @user
          end

          it "saves the new offer in the database" do
            expect {
              post :create, params: { wanted: attributes_for(:wanted), user_id: @user, type: "Wanted" }
            }.to change(Wanted, :count).by(1)
            expect(response).to redirect_to @user
          end
        end

        context "with invalid attributes" do
          it "doesn't save the new offer in the database" do
            expect {
              post :create, params: { user_id: @user, wanted: attributes_for(:invalid_wanted), type: "Wanted" }
            }.not_to change(Wanted, :count)
            expect(assigns(:user)).to eq @user
            expect(response).to render_template(:new)
          end
        end
      end


      describe "PATCH #update" do
        context "with valid attributes" do
          it "locates the requested contact" do
            patch :update, params: { id: @wanted, wanted: attributes_for(:proposal), type: "Wanted" }
            expect(assigns(:proposal)).to eq @wanted
          end

          it "updates the offer in the database" do
            patch :update, params: { id: @wanted, wanted: attributes_for(:wanted, title: "Steampunk"), type: "Wanted" }
            expect(@wanted.reload.title).to eq "Steampunk"
          end
        end

        context "with invalid attributes" do
          it "doesn't update the offer in the database" do
            patch :update,
                  params: {
                    id: @wanted,
                    user_id: @wanted.user,
                    wanted: attributes_for(:wanted, title: nil), type: "Wanted"
                  }
            @wanted.reload
            expect(@wanted).not_to be_nil
          end

          it "re-renders the edit template" do
            patch :update, params: { id: @wanted, user_id: @wanted.user, wanted: attributes_for(:wanted, title: nil), type: "Wanted" }
            expect(response).to render_template :edit
          end
        end
      end

      describe "DELETE #destroy" do
        it "deletes the offer from the database" do
          expect {
            delete :destroy, params: { id: @wanted, type: "Wanted" }
          }.to change(Wanted, :count).by(-1)
        end

        it "redirects to user profile" do
          delete :destroy, params: { id: @wanted, type: "Wanted" }
          expect(response).to redirect_to @user
        end

        it "doesn't allow a user to delete another user's offers" do
          bad_user = create(:user)
          session[:user_id] = bad_user.id
          expect {
            delete :destroy, params: { id: @wanted, type: "Wanted" }
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

  end

  describe "guest" do
    describe "GET #new" do
      it "requires log in" do
        get :new, params: { user_id: 123, type: "Wanted" }
        expect(response).to require_login
      end
    end

    describe "GET #edit" do
      it "requires log in" do
        get :edit, params: { id: 123, type: "Wanted" }
        expect(response).to require_login
      end
    end

    describe "POST #create" do
      it "requires log in" do
        post :create, params: { user_id: 123, type: "Wanted" }
        expect(response).to require_login
      end
    end

    describe "PATCH #update" do
      it "requires login" do
        patch :update, params: { id: "123", type: "Wanted" }
        expect(response).to require_login
      end
    end
  end
end
