class RemoveOfferFromProposal < ActiveRecord::Migration
  def change
    remove_column :proposals, :offer, :boolean
  end
end
