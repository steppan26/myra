class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
    @user_subscriptions = Subscription.where(user_id: current_user).order(renewal_date: :asc)
    @user_monthly_spend = Money.new(@user_subscriptions.sum(:price_per_day_cents) / 12)
    @date = Date.today

    @category_sums = {}
    Category.all.each do |category|
      @user_subscriptions_category = category.subscriptions.where(user_id: current_user)
      monthly_sum = Money.new(@user_subscriptions_category.sum(:price_per_day_cents) / 12)
      @category_sums[category.name] = monthly_sum
    end
  end

  def settings
  end

  def infos
    @user_subscriptions = Subscription.where(user_id: current_user)
    @user_monthly_spend = Money.new(@user_subscriptions.sum(:price_per_day_cents) / 12)
    @my_next_in_payment_subscriptions = Subscription.where(user_id: current_user).order(renewal_date: :asc)
    @date = Date.today

    @category_sums = {}
    Category.all.each do |category|
      @user_subscriptions_category = category.subscriptions.where(user_id: current_user)
      monthly_sum = Money.new(@user_subscriptions_category.sum(:price_per_day_cents) / 12)
      @category_sums[category.name] = monthly_sum
    end

    @user_budgets = Budget.where(user_id: current_user)
  end
end
