class Subscription < ApplicationRecord
  belongs_to :offer
  validates :additional_info, length: { minimum: 5, maximum: 260 }
  validates :price_per_day_cents, numericality: true
  validates :renewal_date, presence: true
  validates :reminder_delay_days, presence: true
end
