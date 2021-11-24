class Category < ApplicationRecord
  has_many :offers
  has_many :services, through: :offers
  validates :name, presence: true, uniqueness: true
end
