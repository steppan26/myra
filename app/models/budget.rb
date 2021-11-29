class Budget < ApplicationRecord
  belongs_to :user
  has_many :subscriptions, through: :user
end
