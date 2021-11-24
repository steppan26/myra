class Service < ApplicationRecord
  has_many :offers, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
