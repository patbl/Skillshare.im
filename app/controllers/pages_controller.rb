class PagesController < ApplicationController
  def home
    @offers = Proposal.offers
    @center = { latlng: [52, 0], zoom: 0 }
    @markers = Proposal.recent.map { |proposal| proposal.to_marker }
  end
end
