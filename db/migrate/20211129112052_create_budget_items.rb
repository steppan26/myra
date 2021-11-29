class CreateBudgetItems < ActiveRecord::Migration[6.1]
  def change
    create_table :budget_items do |t|
      t.references :budget, null: false, foreign_key: true
      t.references :subscription, null: false, foreign_key: true

      t.timestamps
    end
  end
end
