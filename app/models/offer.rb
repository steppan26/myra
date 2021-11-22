class Offer < ApplicationRecord
  belongs_to :service
  belongs_to :category
  belongs_to :user
end
