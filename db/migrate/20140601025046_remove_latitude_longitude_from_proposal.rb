class RemoveLatitudeLongitudeFromProposal < ActiveRecord::Migration
  def change
    remove_column :proposals, :latitude, :float
    remove_column :proposals, :longitude, :float
  end
end
