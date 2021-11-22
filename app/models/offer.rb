class Offer < ApplicationRecord
  PERIODS = ["weekly", "monthly", "annualy"]

  belongs_to :service, optional: true
  belongs_to :category, optional: true
  belongs_to :user

  validates :name, presence: true, length: { minimum: 5, maximum: 30 }
  validates :price_cents, numericality: true, presence: true
  validates :frequency, presence: true, inclusion: PERIODS
end
