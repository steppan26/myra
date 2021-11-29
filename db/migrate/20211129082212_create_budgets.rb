class CreateBudgets < ActiveRecord::Migration[6.1]
  def change
    create_table :budgets do |t|
      t.string :name
      t.integer :price_per_month_cents

      t.timestamps
    end
  end
end
