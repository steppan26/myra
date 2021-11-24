class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    !user.nil? && (record.user == user || user.admin)
  end

end
