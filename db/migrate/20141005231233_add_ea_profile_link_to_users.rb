class AddEaProfileLinkToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :ea_profile_link, :string
  end
end
