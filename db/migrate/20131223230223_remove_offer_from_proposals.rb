class RemoveOfferFromProposals < ActiveRecord::Migration[4.2]
  def change
    remove_column :proposals, :offer, :boolean
  end
end
