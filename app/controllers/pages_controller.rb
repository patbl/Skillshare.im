class PagesController < ApplicationController
  def home
    @offers = Proposal.offers
  end
end
