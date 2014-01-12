require 'spec_helper'

describe UserDecorator, type: :controller do
  describe "#current_user?" do
    before do
      @current_user = build_stubbed(:user).decorate
      @other_user = build_stubbed(:user).decorate
      ApplicationController.any_instance.stub(:current_user).and_return(@current_user)
    end

    it "says that the current user is signed in" do
      expect(@current_user.current_user?).to be_true
    end

    it "says that the other user isn't signed in" do
      expect(@other_user.current_user?).to be_false
    end
  end
end
