require 'spec_helper'

describe ProposalsController do
  shared_examples("public access to proposals") do
    describe "GET #index" do
      it "assigns all a user's offers to @offers and requests to @requests" do
        user = create :user
        offer = create :offer, user: user
        request = create :request, user: user

        get :index, user_id: user

        expect(assigns(:user)).to eq user
        expect(assigns(:offers)).to eq [offer]
        expect(assigns(:requests)).to eq [request]
      end
    end

    describe "GET #show" do
      it "assigns the requested proposal to @proposal" do
        proposal = double("a proposal")
        expect(Proposal).to receive(:find).with("123").and_return(proposal)
        expect(proposal).to receive(:user)

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

    describe "GET #new", skip_before: true do
      it "assigns a new proposal to @proposal" do
        user = create :user
        set_user_session(user)
        get :new, user_id: user
        expect(assigns(:proposal)).to be_a_new(Proposal)
      end
    end

    describe "GET #edit", skip_before: true do
      it "assigns the requested proposal to @proposal" do
        session[:user_id] = "123"
        expect(User).to receive(:find).with("123").and_return("a user")

        proposal = build_stubbed(:proposal)
        expect(Proposal).to receive(:find).with("123").and_return(proposal)

        get :edit, id: "123"

        expect(assigns(:proposal)).to eq proposal
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new proposal in the database" do
          expect {
            post :create, proposal: attributes_for(:proposal), user_id: @user
          }.to change(Proposal, :count).by(1)
          expect(response).to redirect_to Proposal.last
        end

        it "doesn't save the proposal if the user clicks Cancel" do
          session[:return_to] = "previous page"
          expect {
            post :create, proposal: attributes_for(:proposal), user_id: @user, cancel: true
          }.to_not change(Proposal, :count)
          expect(response).to redirect_to("previous page")
        end
      end

      context "with invalid attributes" do
        it "doesn't save the new proposal in the database" do
          expect do
            post :create, user_id: @user, proposal: attributes_for(:invalid_proposal)
          end.to_not change(Proposal, :count)
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
            attributes_for(:proposal, title: 'couch', location: 'Tampa')
          @proposal.reload
          expect(@proposal.title).to eq 'couch'
          expect(@proposal.location).to eq 'Tampa'
        end

        it "redirects to the proposal" do
          patch :update, id: @proposal, proposal: attributes_for(:proposal)
          expect(response).to redirect_to @proposal
          expect(assigns(:user)).to eq @user
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

      context "with cancel" do
        it "doesn't update the record" do
          session[:return_to] = "previous page"
          @proposal.update!(title: "towel")
          patch :update, id: @proposal, proposal: attributes_for(:proposal, title: "pencil"), cancel: true
          @proposal.reload
          expect(@proposal.title).to eq "towel"
          expect(response).to redirect_to "previous page"
        end
      end
    end

    describe "DELETE #destroy" do
      it "deletes the proposal from the database" do
        expect { delete :destroy, id: @proposal, user_id: @proposal.user }
          .to change(Proposal, :count).by(-1)
      end

      it "redirects to users#proposals#index" do
        session[:user_id] = @user.id
        delete :destroy, id: @proposal
        expect(response).to redirect_to user_proposals_path(@user)
      end

      it "doesn't allow a user to delete another user's proposals" do
        nice_user = create(:user)
        bad_user = create(:user)
        proposal = create :proposal, user: nice_user
        session[:user_id] = bad_user
        expect { delete :destroy, id: proposal, user_id: bad_user}
          .to_not change(Proposal, :count)
        expect(response).to redirect_to(root_url)
      end

      it "deletes the user's proposals when the user's account is deleted" do
        expect { User.find(@user.id).destroy }
          .to change(Proposal, :count).by(-1)
      end
    end
  end

  describe "filtering" do
    before { create :offer, category_list: "goods" }

    it "gets all the offers when unfiltered" do
      get :filter
      expect(assigns(:offers)).to eq Proposal.offers
    end

    it "doesn't show anything if there's nothing" do
      get :filter, category: "lodging"
      expect(assigns(:offers)).to be_empty
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
  end
end
