class RemoveLocationFromProposal < ActiveRecord::Migration[4.2]
  def change
    remove_column :proposals, :location, :string
  end
end
