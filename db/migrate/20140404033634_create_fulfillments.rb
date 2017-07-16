class CreateFulfillments < ActiveRecord::Migration[4.2]
  def change
    create_table :fulfillments do |t|
      t.references :fulfiller, index: true
      t.references :wanter, index: true
      t.references :wanted, index: true

      t.timestamps
    end
  end
end
