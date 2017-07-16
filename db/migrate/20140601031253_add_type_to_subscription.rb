class AddTypeToSubscription < ActiveRecord::Migration[4.2]
  def up
    add_column :subscriptions, :type, :string
    Subscription.all.each do |subscription|
      user = subscription.user
      frequency = subscription.frequency
      activeness = subscription.active?
      UpdatesSubscription.create!(user: user, frequency: frequency, active: activeness)
      subscription.destroy!
    end
  end

  def down
    remove_column :subscriptions, :type, :string
  end
end
