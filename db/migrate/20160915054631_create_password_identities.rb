class CreatePasswordIdentities < ActiveRecord::Migration[5.0]
  def change
    create_table :password_identities do |t|
      t.references :user, foreign_key: true, null: false
      t.string :password_digest, null: false
    end
  end
end
