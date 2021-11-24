class Service < ApplicationRecord
  has_many :offers
  validates :name, presence: true, uniqueness: true

  include PgSearch::Model
  pg_search_scope :search_for_offers,
                  against: :name,
                  using: {
                    tsearch: { prefix: true }
                  }
end
