class AddSecureKeyToSubscription < ActiveRecord::Migration[4.2]
  def up
    add_column :subscriptions, :secure_key, :string
    Subscription.all.each do |subscription|
      subscription.generate_secure_key
      subscription.save!
    end
  end

  def down
    remove_column :subscriptions, :secure_key
  end
end
