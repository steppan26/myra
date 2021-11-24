class SubscriptionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    return true
  end

  def update?
    !user.nil? && (record.user == user || user.admin)
  end

  def destroy?
    !user.nil? && (record.user == user || user.admin)
  end

  def search?
    return true
  end
end
