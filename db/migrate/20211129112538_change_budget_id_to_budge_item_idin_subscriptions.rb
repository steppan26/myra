class ChangeBudgetIdToBudgeItemIdinSubscriptions < ActiveRecord::Migration[6.1]
  def change
    rename_column :subscriptions, :budget_id, :budget_item_id
  end
end
