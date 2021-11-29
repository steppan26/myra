class Budget < ApplicationRecord
  belongs_to :user
  has_many :budget_items, dependent: :destroy
  has_many :subscriptions, through: :budget_items
end
