class CreateRequisitions < ActiveRecord::Migration[4.2]
  def change
    create_table :requisitions do |t|
      t.references :requester, index: true
      t.references :offerer, index: true
      t.references :offer, index: true

      t.timestamps
    end
  end
end
