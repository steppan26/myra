class SubscriptionsController < ApplicationController
  before_action :set_subscriptions, only: [:show, :edit, :update, :destroy]

  def index
    @subscriptions = Subscription.all
  end

  def show
  end

  def new
    @subscription = Subscription.new
    authorize @subscription
  end

  def create
    raise
    authorize @subscription
  end

  def edit
    authorize @subscription
  end

  def update
    @subscription.update(subscription_params)
    authorize @subscription
  end

  def destroy
     authorize @subscription
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
end
