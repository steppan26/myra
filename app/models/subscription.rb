class Subscription < ApplicationRecord
  belongs_to :offer, optional: true
  has_one_attached :photo

  validates :additional_info, length: { maximum: 260 }
  validates :price_per_day_cents, presence: true
  validates :renewal_date, presence: true
  validates :reminder_delay_days, presence: true
  monetize :price_per_day_cents
end
