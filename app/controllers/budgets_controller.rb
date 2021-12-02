class BudgetsController < ApplicationController
  after_action :authorize_budget, only: %i[new show create destroy]

  def index
    @budgets = Budget.where(user_id: current_user.id)
  end

  def show
    @budget = Budget.find(params[:id])
    @subscriptions = @budget.subscriptions
    user_subscriptions = Subscription.where(user_id: current_user)
    @filtered_subscriptions = user_subscriptions.reject { |sub| @subscriptions.include?(sub) }
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
      redirect_to budgets_path
    else
      render :new
    end
  end

  def update
    @budget = Budget.find(params[:id])
    sub_ids = params[:selectedSubs].split(',')
    sub_ids.each do |sub_id|
      BudgetItem.create(budget_id: @budget.id, subscription_id: sub_id.to_i)
    end
    authorize :budget
    render partial: 'budgets/current_subscriptions_list', locals: { budget: @budget }
    #redirect_to budget_path(@budget)
  end

  def update_show_header
    @budget = Budget.find(params[:id])
    authorize :budget
    render partial: 'budgets/show_header', locals: { budget: @budget }
  end

  def updateInfo
    authorize :budget
    @budget = Budget.find(params[:id])
    @budget.name = params[:name]
    @budget.price_per_month = params[:price]
    @budget.save
    redirect_to budget_path(@budget)
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
