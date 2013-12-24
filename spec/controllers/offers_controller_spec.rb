require 'spec_helper'

describe OffersController do
  shared_examples "public access to Offers" do
    describe "#index" do
      before { create :offer, category_list: "goods" }

      it "gets all the offers when unfiltered" do
        get :index
        expect(assigns(:offers)).to eq Offer.order(created_at: :desc)
      end

      it "doesn't show anything if there's nothing" do
        get :index, category: "lodging"
        expect(response).to render_template(:index)
        expect(assigns(:offers)).to be_empty
      end
    end

    describe "GET #show" do
      it "assigns the requested offer to @offer" do
        proposal = double("a offer")
        expect(Offer).to receive(:find).with("123").and_return(proposal)

        get :show, id: "123"

        expect(assigns(:offer)).to eq proposal
      end
    end
  end

  describe "user" do
    it_behaves_like "public access to Offers"

    before do
      unless example.metadata[:skip_before]
        @offer = create(:offer)
        @user = @offer.user
        set_user_session(@user)
      end
    end

    describe "GET #new" do
      it "assigns a new offer to @offer" do
        get :new, user_id: @user
        expect(assigns(:offer)).to be_a_new(Offer)
      end
    end

    describe "GET #edit", skip_before: true do
      it "assigns the requested offer to @offer" do
        session[:user_id] = "123"
        user = build_stubbed(:user)
        expect(User).to receive(:find).with("123").and_return(user)

        expect(user.offers).to receive(:find).with("123").and_return("a offer")

        get :edit, id: "123"

        expect(assigns(:offer)).to eq "a offer"
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new offer in the database" do
          expect {
            post :create, offer: attributes_for(:offer), user_id: @user
          }.to change(Offer, :count).by(1)
          expect(response).to redirect_to @user
        end

        it "saves the new offer in the database" do
          expect {
            post :create, offer: attributes_for(:offer), user_id: @user
          }.to change(Offer, :count).by(1)
          expect(response).to redirect_to @user
        end
      end

      context "with invalid attributes" do
        it "doesn't save the new offer in the database" do
          expect do
            post :create, user_id: @user, offer: attributes_for(:invalid_offer)
          end.to_not change(Offer, :count)
          expect(assigns(:user)).to eq @user
          expect(response).to render_template(:new)
        end
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        it "located the requested contact" do
          patch :update, id: @offer, offer: attributes_for(:offer)
          expect(assigns(:offer)).to eq @offer
        end

        it "updates the offer in the database" do
          patch :update, id: @offer, offer:
            attributes_for(:offer, title: "couch", location: "Tampa")
          @offer.reload
          expect(@offer.title).to eq "couch"
          expect(@offer.location).to eq "Tampa"
        end
      end

      context "with  attributes" do
        it "doesn't update the offer in the database" do
          patch :update, id: @offer, user_id: @offer.user, offer:
            attributes_for(:offer, title: nil)
          @offer.reload
          expect(@offer).to_not be_nil
        end

        it "re-renders the :edit template" do
          patch :update, id: @offer, user_id: @offer.user, offer:
            attributes_for(:offer, title: nil)
          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE #destroy" do
      it "deletes the offer from the database" do
        session[:user_id] = "1"
        user = build_stubbed(:user)
        expect(User).to receive(:find).with("1").and_return(user)
        offer = build_stubbed(:offer)
        expect(user.offers).to receive(:find).with("456").and_return(offer)
        expect(offer).to receive(:destroy)

        delete :destroy, id: "456"
      end

      it "redirects to user profile" do
        session[:user_id] = @user.id
        delete :destroy, id: @offer
        expect(response).to redirect_to @user
      end

      it "doesn't allow a user to delete another user's Offers" do
        nice_user = create(:user)
        bad_user = create(:user)
        proposal = create :offer, user: nice_user
        session[:user_id] = bad_user
        expect { delete :destroy, id: proposal, user_id: bad_user}
          .to raise_error(ActiveRecord::RecordNotFound)
      end

      it "deletes the user's Offers when the user's account is deleted" do
        expect { User.find(@user.id).destroy }
          .to change(Offer, :count).by(-1)
      end
    end
  end

  describe "guest" do
    it_behaves_like "public access to Offers"

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
