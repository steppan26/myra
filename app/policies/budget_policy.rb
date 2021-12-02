class BudgetPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def updateInfo?
    true
  end

  def update_show_header?
    true
  end

  def destroy?
    true
  end

  def destroy_budget_item?
    true
  end
end
