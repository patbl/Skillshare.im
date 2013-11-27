require 'spec_helper'

describe ProposalsController do
  shared_examples "public access to proposals" do
    describe "#index" do
      before { create :offer, category_list: "goods" }

      it "gets all the offers when unfiltered" do
        get :index
        expect(assigns(:offers)).to eq Proposal.offers
      end

      it "doesn't show anything if there's nothing" do
        get :index, category: "lodging"
        expect(assigns(:offers)).to be_empty
      end
    end

    describe "GET #show" do
      it "assigns the requested proposal to @proposal" do
        proposal = double("a proposal")
        expect(Proposal).to receive(:find).with("123").and_return(proposal)

        get :show, id: "123"

        expect(assigns(:proposal)).to eq proposal
      end
    end
  end

  describe "user" do
    it_behaves_like "public access to proposals"

    let(:invalid_proposal) { build(:invalid_proposal) }

    before do
      unless example.metadata[:skip_before]
        @proposal = create(:proposal)
        @user = @proposal.user
        set_user_session(@user)
      end
    end

    describe "GET #new" do
      it "assigns a new proposal to @proposal" do
        get :new, user_id: @user
        expect(assigns(:proposal)).to be_a_new(Proposal)
      end
    end

    describe "GET #edit", skip_before: true do
      it "assigns the requested proposal to @proposal" do
        session[:user_id] = "123"
        user = build_stubbed(:user)
        expect(User).to receive(:find).with("123").and_return(user)

        expect(user.proposals).to receive(:find).with("123").and_return("a proposal")

        get :edit, id: "123"

        expect(assigns(:proposal)).to eq "a proposal"
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new proposal in the database" do
          expect {
            post :create, proposal: attributes_for(:proposal), user_id: @user
          }.to change(Proposal, :count).by(1)
          expect(response).to redirect_to @user
        end

        it "saves the new proposal in the database" do
          expect {
            post :create, proposal: attributes_for(:proposal), user_id: @user
          }.to change(Proposal, :count).by(1)
          expect(response).to redirect_to @user
        end
      end

      context "with invalid attributes" do
        it "doesn't save the new proposal in the database" do
          expect do
            post :create, user_id: @user, proposal: attributes_for(:invalid_proposal)
          end.to_not change(Proposal, :count)
          expect(assigns(:user)).to eq @user
          expect(response).to render_template(:new)
        end
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        it "located the requested contact" do
          patch :update, id: @proposal, proposal: attributes_for(:proposal)
          expect(assigns(:proposal)).to eq @proposal
        end

        it "updates the proposal in the database" do
          patch :update, id: @proposal, proposal:
            attributes_for(:proposal, title: "couch", location: "Tampa")
          @proposal.reload
          expect(@proposal.title).to eq "couch"
          expect(@proposal.location).to eq "Tampa"
        end
      end

      context "with invalid attributes" do
        it "doesn't update the proposal in the database" do
          patch :update, id: @proposal, user_id: @proposal.user, proposal:
            attributes_for(:proposal, title: nil)
          @proposal.reload
          expect(@proposal).to_not be_nil
        end

        it "re-renders the :edit template" do
          patch :update, id: @proposal, user_id: @proposal.user, proposal:
            attributes_for(:proposal, title: nil)
          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE #destroy" do
      it "deletes the proposal from the database" do
        session[:user_id] = "1"
        user = build_stubbed(:user)
        expect(User).to receive(:find).with("1").and_return(user)
        proposal = build_stubbed(:proposal)
        expect(user.proposals).to receive(:find).with("456").and_return(proposal)
        expect(proposal).to receive(:destroy)

        delete :destroy, id: "456"
      end

      it "redirects to user profile" do
        session[:user_id] = @user.id
        delete :destroy, id: @proposal
        expect(response).to redirect_to @user
      end

      it "doesn't allow a user to delete another user's proposals" do
        nice_user = create(:user)
        bad_user = create(:user)
        proposal = create :proposal, user: nice_user
        session[:user_id] = bad_user
        expect { delete :destroy, id: proposal, user_id: bad_user}
          .to raise_error(ActiveRecord::RecordNotFound)
      end

      it "deletes the user's proposals when the user's account is deleted" do
        expect { User.find(@user.id).destroy }
          .to change(Proposal, :count).by(-1)
      end
    end
  end

  describe "guest" do
    it_behaves_like "public access to proposals"

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
        proposal = create(:proposal)
        patch :update, id: proposal
        expect(response).to require_login
      end
    end

    describe "GET #map" do
      it "assigns @markers correctly" do
        offer = create :offer, title: "love", category_list: "lodging"
        offer.update(latitude: 1.0, longitude: 2.0)
        get :map
        link = ActionController::Base.helpers.link_to("love", proposal_path(offer))
        expect(assigns(:marker_data)).to eq [{ latlng: [1.0, 2.0], popup: link, icon: "home"  }]
      end
    end
  end
end
