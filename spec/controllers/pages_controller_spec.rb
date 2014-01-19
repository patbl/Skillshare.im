require 'spec_helper'

describe PagesController do
  context "#about" do
    it "renders the about template" do
      get :about
      expect(response).to render_template(:about)
    end
  end

  context "#faq" do
    it "renders the FAQ template" do
      get :faq
      expect(response).to render_template(:faq)
    end
  end
end
