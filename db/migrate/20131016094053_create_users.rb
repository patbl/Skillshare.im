class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :provider
      t.string   :uid
      t.string   :name
      t.string   :email
      t.string   :image
      t.string   :facebook_profile
      t.string   :location
      t.float    :latitude
      t.float    :longitude
      t.string   :oauth_token
      t.datetime :oauth_expires_at
      t.text     :about
      t.boolean  :admin

      t.timestamps

      create_table :proposals do |t|
        t.belongs_to :user

        t.string     :title
        t.text       :description
        t.string     :location
        t.float      :latitude
        t.float      :longitude
        t.boolean    :offer

        t.timestamps
      end
    end
  end
end
