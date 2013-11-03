class PagesController < ApplicationController
  def show
    @offers = Proposal.offers
  end
end
