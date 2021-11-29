class BudgetItem < ApplicationRecord
  belongs_to :budget
  belongs_to :subscription
end
