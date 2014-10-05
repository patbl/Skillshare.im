class AddEaProfileLinkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ea_profile_link, :string
  end
end
