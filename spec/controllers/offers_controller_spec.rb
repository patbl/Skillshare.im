require 'spec_helper'

describe OffersController do
  shared_examples "public access to offers" do
    describe "#index" do
      before { @offer = create(:offer, category_list: "goods") }

      describe "when unfiltered" do
        it "gets all the offers when unfiltered" do

          get :index
          expect(assigns(:offers)).to eq Offer.order(created_at: :desc)
        end
      end

      describe "when filtered" do
        it "doesn't show anything if there's nothing" do
          get :index, category: "lodging"
          expect(response).to render_template(:index)
          expect(assigns(:offers)).to be_empty
        end

        it "shows offers from the relevant category if they exist" do
          get :index, category: "goods"
          expect(assigns(:offers)).to match_array [@offer]
        end
      end

      it "paginates offers" do
        filtered_offers = double()
        expect(Offer).to receive(:filter_by_tag).and_return(filtered_offers)
        paginated_offers = double()
        expect(filtered_offers).to receive(:page).with("2").and_return paginated_offers
        paginated_offers.stub_chain(:per, :decorate).and_return "decorated offers"

        get :index, page: "2"

        expect(assigns(:offers)).to eq "decorated offers"
      end

      it "renders the Atom feed" do
        get :index, format: "atom"
        expect(response).to render_template(:index)
        expect(response.content_type).to eq("application/atom+xml")
        expect(assigns(:updated_at)).to be_same_second_as @offer.updated_at
      end
    end

    describe "GET #show" do
      it "assigns the requested offer to @offer" do
        offer = double
        expect(Offer).to receive(:find).with("123").and_return(offer)
        expect(offer).to receive(:decorate).and_return("decorated offer")

        get :show, id: "123"

        expect(assigns(:offer)).to eq "decorated offer"
      end
    end
  end

  describe "user" do
    context "looking at stuff" do
      it_behaves_like "public access to offers"
    end

    context "changing stuff" do
      before do |example|
        @offer = create(:offer, category_list: "lodging", title: "qqqqqq")
        @user = @offer.user
        set_user_session(@user)
      end


      describe "GET #new" do
        it "assigns a new offer to @offer" do
          get :new, user_id: @user
          expect(assigns(:offer)).to be_a_new(Offer)
        end
      end

      describe "GET #edit" do
        it "assigns the requested offer to @offer" do
          get :edit, id: @offer

          expect(assigns(:offer)).to eq @offer
        end
      end

      describe "POST #create" do
        context "with valid attributes" do
          it "saves the new offer in the database" do
            expect { post :create, offer: attributes_for(:offer), user_id: @user }
              .to change(Offer, :count).by(1)
            expect(response).to redirect_to @user
          end

          it "saves the new offer in the database" do
            expect { post :create, offer: attributes_for(:offer), user_id: @user }
              .to change(Offer, :count).by(1)
            expect(response).to redirect_to @user
          end
        end

        context "with invalid attributes" do
          it "doesn't save the new offer in the database" do
            expect { post :create, user_id: @user, offer: attributes_for(:invalid_offer) }
              .not_to change(Offer, :count)
            expect(assigns(:user)).to eq @user
            expect(response).to render_template(:new)
          end
        end
      end

      describe "PATCH #update" do
        context "with valid attributes" do
          it "locates the requested contact" do
            patch :update, id: @offer, offer: attributes_for(:offer)
            expect(assigns(:offer)).to eq @offer
          end

          it "updates the offer in the database" do
            patch :update, id: @offer, offer:
              attributes_for(:offer, location: "Tampa")
            @offer.reload
            expect(@offer.location).to eq "Tampa"
          end
        end

        context "with invalid attributes" do
          it "doesn't update the offer in the database" do
            patch :update, id: @offer, user_id: @offer.user, offer:
              attributes_for(:offer, title: nil)
            @offer.reload
            expect(@offer).not_to be_nil
          end

          it "re-renders the edit template" do
            patch :update, id: @offer, user_id: @offer.user, offer:
              attributes_for(:offer, title: nil)
            expect(response).to render_template :edit
          end
        end
      end

      describe "DELETE #destroy" do
        it "deletes the offer from the database" do
          expect { delete :destroy, id: @offer }.to change(Offer, :count).by(-1)
        end

        it "redirects to user profile" do
          delete :destroy, id: @offer
          expect(response).to redirect_to @user
        end

        it "doesn't allow a user to delete another user's offers" do
          nice_user = create(:user)
          bad_user = create(:user)
          proposal = create :offer, user: nice_user
          session[:user_id] = bad_user
          expect { delete :destroy, id: proposal, user_id: bad_user }
            .to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe "guest" do
    it_behaves_like "public access to offers"

    describe "GET #new" do
      it "requires log in" do
        get :new, user_id: 123
        expect(response).to require_login
      end
    end

    describe "GET #edit" do
      it "requires log in" do
        get :edit, id: 123
        expect(response).to require_login
      end
    end

    describe "POST #create" do
      it "requires log in" do
        post :create, user_id: 123
        expect(response).to require_login
      end
    end

    describe "PATCH #update" do
      it "requires login" do
        proposal = create(:offer)
        patch :update, id: proposal
        expect(response).to require_login
      end
    end
  end
end
