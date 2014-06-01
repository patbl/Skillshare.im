class RemoveNameFromSubscription < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :name, :string
  end
end
