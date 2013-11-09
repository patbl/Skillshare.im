require 'spec_helper'

describe MessagesController do
  
  describe "GET :new" do
    it "requires the user to be signed in" do
      get :new, user_id: 1
      expect(response).to redirect_to signin_path
    end

    it "renders the contact form when a user is signed in" do
      sender = create :user
      recipient = create :user
      session[:user_id] = sender.id
      get :new, user_id: recipient
      expect(response).to render_template :new
    end
  end

  describe "POST :create" do
    it "requires the user to be signed in" do
      user = create(:user)
      post :create, user_id: user, message: attributes_for(:message)
      expect(response).to redirect_to signin_path
    end

    it "saves the message if things are Kosher" do
      sender = create :user
      recipient = create :user
      session[:user_id] = sender
      expect {
        post :create, user_id: recipient, message: attributes_for(:message)
      }.to change(Message, :count).by(1)
      expect(response).to redirect_to(recipient)
    end

    it "sends the e-mail message if the record is valid" do
      sender = create :user
      recipient = create :user
      session[:user_id] = sender
      post :create, user_id: recipient, message: attributes_for(:message)
      expect(last_email.to).to include(recipient.email)
    end

    it "dosn't send the e-mail message if the record isn't valid" do
      sender = create :user
      recipient = create :user
      session[:user_id] = sender
      expect {
        post :create, user_id: recipient, message: attributes_for(:message, subject: nil)
      }.to_not change(Message, :count)
      expect(response).to render_template(:new)
    end

  end

end
