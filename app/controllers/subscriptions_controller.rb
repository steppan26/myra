class SubscriptionsController < ApplicationController
  before_action :set_subscriptions, only: [:show, :edit, :update, :destroy]

  def index
    @subscriptions = Subscription.all
    user_subscriptions = Subscription.where(user_id: current_user)
    user_subscriptions.each { |sub| p sub }
    @user_spend = user_subscriptions.sum { |sub| sub.price_per_day_cents } * 30
    raise
  end

  def show
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.user = current_user
    @subscription.offer =
    @subscription.save!
  end

  def edit
  end

  def update
    @subscription.update(subscription_params)
  end

  def destroy
    @subscription.destroy
    redirect_to "/subscriptions"
  end

  private

  def subscription_params
    params.require(:subscription).permit(:additional_info, :url, :price_per_day_cents, :renewal_date, :reminder_delay_days)
  end

  def set_subscriptions
    @subscription = Subscription.find(params[:id])
  end
end
