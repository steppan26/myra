class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.references :offer, null: false, foreign_key: true
      t.references :user
      t.text :additional_info
      t.integer :price_per_day_cents
      t.date :renewal_date
      t.integer :reminder_delay_days
      t.boolean :is_active
      t.string :url

      t.timestamps
    end
  end
end
