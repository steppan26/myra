class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :offer, optional: true
  has_one_attached :photo

  has_many :budgets
  has_many :budget_items
  validates :additional_info, length: { maximum: 260 }
  validates :price_per_day_cents, presence: true
  validates :renewal_date, presence: true
  validates :reminder_delay_days, presence: true
  monetize :price_per_day_cents
end
