class Offer < ApplicationRecord
  PERIODS = ["weekly", "monthly", "annualy"]

  belongs_to :service, optional: true
  belongs_to :category, optional: true
  belongs_to :user
  has_many :subscriptions, dependent: :destroy

  # length: { minimum: 5, maximum: 30 }
  validates :name, presence: true
  validates :price_cents, presence: true
  validates :frequency, presence: true, inclusion: PERIODS
  monetize :price_cents
end
