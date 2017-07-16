class AddTypeToProposals < ActiveRecord::Migration[4.2]
  def change
    add_column :proposals, :type, :string
  end
end
