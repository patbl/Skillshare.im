class AddLastSentToSubscription < ActiveRecord::Migration
  def up
    add_column :subscriptions, :last_sent, :datetime
    Subscription.all.each do |subscription|
      subscription.update! last_sent: 10.days.ago
    end
  end

  def down
    remove_column :subscription, :last_sent
  end
end
