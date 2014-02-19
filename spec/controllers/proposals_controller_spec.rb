require 'spec_helper'

describe ProposalsController do
  shared_examples "public access to offers" do
    describe "#index" do
      before { @wanted = create(:wanted, category_list: "goods") }

      describe "when unfiltered" do
        it "gets all the offers when unfiltered" do

          get :index, type: "Wanted"
          expect(assigns(:proposals)).to match_array Wanted.order(created_at: :desc)
        end
      end

      describe "when filtered" do
        it "doesn't show anything if there's nothing" do
          get :index, category: "lodging", type: "Wanted"
          expect(response).to render_template(:index)
          expect(assigns(:proposals)).to be_empty
        end

        it "shows offers from the relevant category if they exist" do
          get :index, category: "goods", type: "Wanted"
          expect(assigns(:proposals)).to match_array [@wanted]
        end
      end

      it "paginates offers", skip: true do
        filtered_offers = double
        expect(Proposal).to receive(:filter_by_tag).and_return(filtered_offers)
        paginated_offers = double
        expect(filtered_offers).to receive(:page).with("2").and_return paginated_offers
        paginated_offers.stub_chain(:per, :decorate).and_return "decorated offers"

        get :index, page: "2"

        expect(assigns(:offers)).to eq "decorated offers"
      end

      it "renders the Atom feed" do
        get :index, format: "atom", type: "Wanted"
        expect(response).to render_template(:index)
        expect(response.content_type).to eq("application/atom+xml")
        expect(assigns(:updated_at)).to be_same_second_as @wanted.updated_at
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
          get :new, user_id: @user, type: "Wanted"
          expect(assigns(:proposal)).to be_a_new(Wanted)
          expect(assigns(:user)).to eq @user
        end
      end

      describe "GET #edit" do
        it "assigns the requested wanted to @proposal" do
          get :edit, id: @wanted, type: "Wanted"

          expect(assigns(:proposal)).to eq @wanted
        end

        it "assings the user to @user" do
          get :edit, id: @wanted, type: "Wanted"

          expect(assigns(:user)).to eq @user
        end
      end

      describe "POST #create" do
        context "with valid attributes" do
          it "saves the new wanted in the database" do
            expect { post :create, wanted: attributes_for(:wanted), user_id: @user, type: "Wanted" }
              .to change(Wanted, :count).by(1)
            expect(response).to redirect_to @user
          end

          it "saves the new offer in the database" do
            expect { post :create, wanted: attributes_for(:wanted), user_id: @user, type: "Wanted" }
              .to change(Wanted, :count).by(1)
            expect(response).to redirect_to @user
          end
        end

        context "with invalid attributes" do
          it "doesn't save the new offer in the database" do
            expect { post :create, user_id: @user, wanted: attributes_for(:invalid_wanted), type: "Wanted" }
              .not_to change(Wanted, :count)
            expect(assigns(:user)).to eq @user
            expect(response).to render_template(:new)
          end
        end
      end


      describe "PATCH #update" do
        context "with valid attributes" do
          it "locates the requested contact" do
            patch :update, id: @wanted, wanted: attributes_for(:proposal), type: "Wanted"
            expect(assigns(:proposal)).to eq @wanted
          end

          it "updates the offer in the database" do
            patch :update, id: @wanted, wanted: attributes_for(:wanted, location: "Tampa"), type: "Wanted"
            @wanted.reload
            expect(@wanted.location).to eq "Tampa"
          end
        end

        context "with invalid attributes" do
          it "doesn't update the offer in the database" do
            patch :update, id: @wanted, user_id: @wanted.user, wanted:
              attributes_for(:wanted, title: nil), type: "Wanted"
            @wanted.reload
            expect(@wanted).not_to be_nil
          end

          it "re-renders the edit template" do
            patch :update, id: @wanted, user_id: @wanted.user, wanted:
              attributes_for(:wanted, title: nil), type: "Wanted"
            expect(response).to render_template :edit
          end
        end
      end

      describe "DELETE #destroy" do
        it "deletes the offer from the database" do
          expect { delete :destroy, id: @wanted, type: "Wanted" }.to change(Wanted, :count).by(-1)
        end

        it "redirects to user profile" do
          delete :destroy, id: @wanted, type: "Wanted"
          expect(response).to redirect_to @user
        end

        it "doesn't allow a user to delete another user's offers" do
          bad_user = create(:user)
          session[:user_id] = bad_user
          expect { delete :destroy, id: @wanted, type: "Wanted" }
            .to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

  end

  describe "guest" do
    # it_behaves_like "public access to offers"

    describe "GET #new" do
      it "requires log in" do
        get :new, user_id: 123, type: "Wanted"
        expect(response).to require_login
      end
    end

    describe "GET #edit" do
      it "requires log in" do
        get :edit, id: 123, type: "Wanted"
        expect(response).to require_login
      end
    end

    describe "POST #create" do
      it "requires log in" do
        post :create, user_id: 123, type: "Wanted"
        expect(response).to require_login
      end
    end

    describe "PATCH #update" do
      it "requires login" do
        patch :update, id: "123", type: "Wanted"
        expect(response).to require_login
      end
    end
  end
end
