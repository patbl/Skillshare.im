class AddLastSentToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :last_sent, :datetime
  end
end
