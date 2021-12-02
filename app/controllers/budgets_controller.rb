class BudgetsController < ApplicationController
  after_action :authorize_budget, only: %i[new show create destroy]

  def index
    @budgets = Budget.where(user_id: current_user.id)
  end

  def show
    @budget = Budget.find(params[:id])
    @subscriptions = Subscription.where(budget_id: @budget.id)
    @user_subscriptions = Subscription.where(user_id: current_user)
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
      new_budget_item = BudgetItem.new(budget_id: @budget.id, subscription_id: sub_id)
      new_budget_item.save
      end
      redirect_to budget_path(@budget)
    else
      render :new
    end
  end

  def destroy
    @budget = Budget.find(params[:id])
    @budget.destroy
    redirect_to budgets_path
  end

  private

  def budget_params
    params.require(:budget).permit(:name, :price_per_month)
  end

  def authorize_budget
    authorize @budget
  end
end
