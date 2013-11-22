require 'spec_helper'

describe PagesController do
  context "#about" do
    it "doesn't raise an exception" do
      get :about
    end
  end

  context "#faq" do
    it "doesn't raise an exception" do
      get :faq
    end
  end
end
