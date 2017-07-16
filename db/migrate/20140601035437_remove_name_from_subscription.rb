class RemoveNameFromSubscription < ActiveRecord::Migration[4.2]
  def change
    remove_column :subscriptions, :name, :string
  end
end
