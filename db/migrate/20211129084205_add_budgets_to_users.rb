class AddBudgetsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :budget, index: true
    add_foreign_key :users, :budgets
  end
end
