class RemoveLatitudeLongitudeFromProposal < ActiveRecord::Migration[4.2]
  def change
    remove_column :proposals, :latitude, :float
    remove_column :proposals, :longitude, :float
  end
end
