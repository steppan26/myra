class AddBudgetsToSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_reference :subscriptions, :budget, index: true
    add_foreign_key :subscriptions, :budgets
  end
end
