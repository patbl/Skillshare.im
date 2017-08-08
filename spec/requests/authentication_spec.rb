require "spec_helper"

describe "when there's a request to the obsolete Mozilla Persona endpoint" do
  let!(:identity) { create(:identity) }
  it "404's" do
    expect {
      get "/auth/browser_id/callback"
    }.to raise_error(ActionController::RoutingError)
  end
end
