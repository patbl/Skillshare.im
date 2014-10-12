class RenameEaProfileLink < ActiveRecord::Migration
  def up
    rename_column :users, :ea_profile_link, :ea_profile
  end

  def down
    rename_column :users, :ea_profile, :ea_profile_link
  end
end
