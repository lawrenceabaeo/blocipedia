class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :plan_id
      t.string :stripe_customer_token
      t.references :user, index: true

      t.timestamps
    end
  end
end
