class RemoveLocationFromProposal < ActiveRecord::Migration
  def change
    remove_column :proposals, :location, :string
  end
end
