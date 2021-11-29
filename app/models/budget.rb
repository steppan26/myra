class Budget < ApplicationRecord
  belongs_to :user
  has_many :budget_items
  has_many :subscriptions, through: :budget_items
end
