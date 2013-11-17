require 'spec_helper'

describe PagesController do
  context "#home" do
    it "assigns all the lats and longs to @latlngs" do
      offer = create(:offer, title: "hope")
      offer.update(latitude: 1.0, longitude: 2.0)
      get :home 
      expected = [{ latlng: [1.0, 2.0], popup: "hope" }]
      expect(assigns(:markers)).to eq(expected)
    end
  end
end                                      
