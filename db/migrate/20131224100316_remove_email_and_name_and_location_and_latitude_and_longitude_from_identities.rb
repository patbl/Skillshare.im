class RemoveEmailAndNameAndLocationAndLatitudeAndLongitudeFromIdentities < ActiveRecord::Migration[4.2]
  def change
    remove_column :identities, :email, :string
    remove_column :identities, :name, :string
    remove_column :identities, :location, :string
    remove_column :identities, :latitude, :float
    remove_column :identities, :longitude, :float
  end
end
