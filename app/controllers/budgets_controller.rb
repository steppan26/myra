class BudgetsController < ApplicationController
  after_action :authorize_budget, only: %i[new show create]

  def show
    @budget = Budget.find(params[:id])
    @subscriptions = Subscription.where(budget_id: @budget.id)
  end

  def new
    @budget = Budget.new
  end

  def create
    @budget = Budget.new(budget_params)
    @budget.user_id = current_user.id

    if @budget.save
      redirect_to budget_path(@budget)
    else
      render :new
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:name, :price_per_month_cents)
  end

  def authorize_budget
    authorize @budget
  end
end
