class SubscriptionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def update?
    !user.nil? && (record.user == user || user.admin)
  end

  def destroy?
    !user.nil? && (record.user == user || user.admin)
  end

  def display_services?
    true
  end

  def display_offers?
    true
  end
end
