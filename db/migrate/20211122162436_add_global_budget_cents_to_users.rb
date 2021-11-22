class AddGlobalBudgetCentsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :global_budget_cents, :integer
  end
end
