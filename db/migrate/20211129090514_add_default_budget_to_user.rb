class AddDefaultBudgetToUser < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :global_budget_cents, :integer, default: 0
  end
end
