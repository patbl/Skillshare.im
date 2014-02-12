require 'spec_helper'

describe Offer do
  it_behaves_like "Mappable"

  describe "validations" do
    it "is valid with everything filled in" do
      offer = build :offer
      expect(offer).to be_valid
    end
  end

  describe "geocoding" do
    context "location is 'Anywhere'" do
      it "isn't geocoded" do
        offer = build :offer, location: "Anywhere"
        expect(offer).not_to receive(:geocode)
        offer.save
      end
    end

    context "location isn't 'Anywhere'" do
      it "is geocoded" do
        offer = build :offer, location: "Omaha"
        expect(offer).to receive(:geocode)
        offer.save
      end
    end
  end
end
