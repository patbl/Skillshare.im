class RemoveOfferFromProposals < ActiveRecord::Migration
  def change
    remove_column :proposals, :offer, :boolean
  end
end
