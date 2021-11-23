class SubscriptionsController < ApplicationController
  before_action :set_subscriptions, only: [:show, :edit, :update, :destroy]
  after_action :authorize_subscription, only: [:show, :new, :create, :edit, :update, :destroy]
  def index
    @subscriptions = Subscription.all
  end

  def show
  end

  def new
    @subscription = Subscription.new
  end

  def create
    raise
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
    params.require(:subscription).permit(:additional_info, :url, :renewal_date, :reminder_delay_days, :image_url)
  end

  def set_subscriptions
    @subscription = Subscription.find(params[:id])
  end

  def authorize_subscription
    authorize @subscription
  end
end
