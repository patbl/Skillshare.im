class AddTypeToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :type, :string
  end
end
