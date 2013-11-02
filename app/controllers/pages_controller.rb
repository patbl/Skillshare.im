class PagesController < ApplicationController
  def show
    @proposals = Proposal.recent
  end
end
