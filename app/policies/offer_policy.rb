class OfferPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    return true
  end

  def update?
    record.user == user || user.admin == true
  end

  def destroy?
    record.user == user || user.admin == true
  end
end
