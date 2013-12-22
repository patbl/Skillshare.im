class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :provider
      t.string :uid
      t.string :email
      t.string :name
      t.string :location
      t.float :latitude
      t.float :longitude
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.references :user, index: true

      t.timestamps
    end
  end
end
