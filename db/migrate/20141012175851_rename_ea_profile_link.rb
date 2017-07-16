class RenameEaProfileLink < ActiveRecord::Migration[4.2]
  def up
    rename_column :users, :ea_profile_link, :ea_profile
  end

  def down
    rename_column :users, :ea_profile, :ea_profile_link
  end
end
