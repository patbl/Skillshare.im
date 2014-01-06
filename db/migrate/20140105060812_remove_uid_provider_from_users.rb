class RemoveUidProviderFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :uid, :string
    remove_column :users, :provider, :string
  end
end
