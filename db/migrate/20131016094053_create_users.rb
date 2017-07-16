class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string   :provider
      t.string   :uid
      t.string   :name
      t.string   :email
      t.string   :facebook_url
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

    add_index :proposals, :user_id
  end
end
