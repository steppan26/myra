class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google, :apple]
  has_many :subscriptions, dependent: :destroy
  has_many :offers, through: :subscriptions, optional: true
  monetize :global_budget_cents
end
