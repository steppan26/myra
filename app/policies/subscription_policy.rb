class SubscriptionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    return true
  end

  def create?
    true
  end

  def update?
    !user.nil? && (record.user_id == user.id || user.admin)
  end

  def destroy?
    !user.nil? && (record.user_id == user.id || user.admin)
  end

  def display_services?
    true
  end

  def display_offer_form?
    true
  end

  def display_offers?
    true
  end
end
