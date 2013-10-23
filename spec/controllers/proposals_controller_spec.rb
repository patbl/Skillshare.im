require 'spec_helper'

describe ProposalsController do
  let(:proposal) { create(:proposal) }
  let(:invalid_proposal) { build(:invalid_proposal) }

  describe "GET #index" do
    let(:proposals) { create_list(:proposal, 3) }
    before { get :index }
    it "assigns all proposals to @proposals" do
      expect(assigns(:proposals)).to match_array proposals
    end
    it "render the :index template" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before { get :show, id: proposal }
    it "assigns the requested proposal to @proposal" do
      expect(assigns(:proposal)).to eq proposal
    end
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    it "assigns the a new Proposal to @proposal" do
      get :new
      expect(assigns(:proposal)).to be_a_new(Proposal)
    end
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    before { get :edit, id: proposal }
    it "assigns the requested proposal to @proposal" do
      expect(assigns(:proposal)).to eq proposal
    end
    it "renders the :edit template" do
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new proposal in the database" do
        expect { post :create, proposal: attributes_for(:proposal) }
          .to change(Proposal, :count).by(1)
        expect(response).to render_template(:show)
      end
    end
    context "with invalid attributes" do
      it "doesn't save the new proposal in the database" do
        expect { post :create, proposal: attributes_for(:invalid_proposal) }
          .to_not change(Proposal, :count)
      end
      it "re-renders the :new template" do
        post :create, proposal: attributes_for(:invalid_proposal)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "located the requested contact" do
        patch :update, id: proposal, user_id: proposal.user,
                       proposal: attributes_for(:proposal)
        expect(assigns(:proposal)).to eq proposal
      end
      it "updates the proposal in the database" do
        patch :update, id: proposal, user_id: proposal.user, proposal:
          attributes_for(:proposal, title: 'couch', location: 'Tampa')
        proposal.reload
        expect(proposal.title).to eq 'couch'
        expect(proposal.location).to eq 'Tampa'
      end
      it "redirects to the proposal" do
        user = proposal.user
        patch :update, id: proposal, user_id: user,
                       proposal: attributes_for(:proposal)
        expect(response).to redirect_to [user, proposal]
        expect(assigns(:user)).to eq user
      end
    end
    context "with invalid attributes" do
      it "doesn't update the proposal in the database" do
        patch :update, id: proposal, proposal:
          attributes_for(:proposal, title: nil)
        proposal.reload
        expect(proposal).to_not be_nil
      end
      it "re-renders the :edit template" do
        patch :update, id: proposal, proposal:
          attributes_for(:proposal, title: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the proposal from the database" do
      proposal
      expect { delete :destroy, id: proposal, user_id: proposal.user }
        .to change(Proposal, :count).by(-1)
    end
    it "redirects to users#proposals#index" do
      proposal.save!
      delete :destroy, id: proposal, user_id: proposal.user
      expect(response).to redirect_to user_proposals_path(proposal.user)
    end
  end

end
