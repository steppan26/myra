class BudgetsController < ApplicationController
  after_action :authorize_budget, only: %i[new show create]

  def index
    @budgets = Budget.where(user_id: current_user.id)
  end

  def show
    @budget = Budget.find(params[:id])
    @subscriptions = Subscription.where(budget_id: @budget.id)
  end

  def new
    @budget = Budget.new
    @subscriptions = Subscription.where(user_id: current_user)
  end

  def create
    @budget = Budget.new(budget_params)
    @budget.user_id = current_user.id
    if @budget.save
      params[:budget][:subscription_ids].each do |sub_id|
        next if sub_id == ""
        budget_item = BudgetItem.create(subscription_id: sub_id, budget_id: @budget.id)
        sub = Subscription.find(sub_id)
        sub.budget_item_id = budget_item.id
        sub.save
    end
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
