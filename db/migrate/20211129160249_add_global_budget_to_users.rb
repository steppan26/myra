class AddGlobalBudgetToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :global_budget, :integer, default: 0
  end
end
