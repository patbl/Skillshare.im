class PagesController < ApplicationController
  def show
    @proposals = Proposal.all
  end
end
