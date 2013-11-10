require 'spec_helper'

describe MessagesController do
  
  describe "GET :new" do
    it "requires the user to be signed in" do
      get :new, proposal_id: 1
      expect(response).to redirect_to signin_path
    end

    it "renders the contact form when a user is signed in" do
      sender = create :user
      session[:user_id] = sender.id
      expect(Proposal).to receive(:find)
      get :new, proposal_id: "123"
      expect(response).to render_template :new
    end
  end

  describe "POST :create" do
    it "requires the user to be signed in" do
      post :create, proposal_id: "123", message: attributes_for(:message)
      expect(response).to redirect_to signin_path
    end

    it "saves the message if things are Kosher" do
      sender = create :user
      proposal = create :proposal
      session[:user_id] = sender
      expect {
        post :create, proposal_id: proposal, message: attributes_for(:message)
      }.to change(Message, :count).by(1)
      expect(response).to redirect_to(proposal)
    end

    it "sends the e-mail message if the record is valid" do
      sender = create :user
      session[:user_id] = sender
      proposal = create :proposal
      post :create, proposal_id: proposal, message: attributes_for(:message)
      expect(last_email.to).to include(proposal.user.email)
    end

    it "dosn't send the e-mail message if the record isn't valid" do
      sender = create :user
      proposal = create :proposal 
      session[:user_id] = sender
      expect {
        post :create, proposal_id: proposal, message: attributes_for(:message, body: nil)
      }.to_not change(Message, :count)
      expect(response).to render_template(:new)
    end

  end

end
