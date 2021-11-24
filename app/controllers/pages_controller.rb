class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
    user_subscriptions = Subscription.where(user_id: current_user)
    @user_monthly_spend = (user_subscriptions.sum { |sub| sub.price_per_day_cents } * 30) / 100
    @my_next_in_payment_subscriptions = Subscription.where(user_id: current_user).order(renewal_date: :asc).first(5)
    @date = Date.today

    @category_sums = {}
    Category.all.each do |category|
      user_subscriptions_category = category.subscriptions.where(user_id: current_user)
      monthly_sum = (user_subscriptions_category.sum { |sub| sub.price_per_day_cents } * 30) / 100
      @category_sums[category.name] = monthly_sum
    end
  end

  def settings
    @user = current_user
  end
end
