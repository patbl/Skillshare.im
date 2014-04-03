require 'spec_helper'

describe "requisition tracking" do
  it "keeps track of how many times an offer is requested" do
    offer = create :offer, title: "Hay"
    user = sign_in

    click_link "Hay"
    click_button "Send"

    expect(Requisition.count).to eq 1
  end
end
