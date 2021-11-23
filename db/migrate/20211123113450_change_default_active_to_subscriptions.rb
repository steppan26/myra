class ChangeDefaultActiveToSubscriptions < ActiveRecord::Migration[6.1]
  def change
    change_column :subscriptions, :is_active, :boolean, default: true
  end
end
