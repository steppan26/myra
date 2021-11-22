class Category < ApplicationRecord
  has_many :offers
  validates :name, presence: true, uniqueness: true
end
