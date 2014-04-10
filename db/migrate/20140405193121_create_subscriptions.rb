class CreateSubscriptions < ActiveRecord::Migration
  def up
    create_table :subscriptions do |t|
      t.references :user, index: true
      t.boolean :active
      t.integer :frequency

      t.timestamps
    end

    User.all.each do |user|
      Subscription.create!(user: user, active: true, frequency: :biweekly) if user.subscriptions.empty?
    end
  end

  def down
    drop_table :subscriptions
  end
end
