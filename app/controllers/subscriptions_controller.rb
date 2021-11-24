class SubscriptionsController < ApplicationController
  before_action :set_subscriptions, only: %i[show edit update destroy]

  def index
    @subscriptions = Subscription.all
    user_subscriptions = Subscription.where(user_id: current_user)
    @user_monthly_spend = (user_subscriptions.sum { |sub| sub.price_per_day_cents } * 30) / 100
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

  def new
    @subscription = Subscription.new
    @category = Category.all.map { |category| category.name }

    if params[:query].present?
      @services = Service.where("name ILIKE ?" "%#{params[:query]}%")
    else
      @services = Service.all
    end
    # @services = Service.all.map { |service| service.name }
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

  def search
    @category = Category.where(name: params[:query]).first
    @services = @category.services.uniq
    p @services
    # search_for_services(params[:query])
    authorize :subscription
    render partial: 'search', locals: { services: @services }

  end

  private

  def subscription_params
    params.require(:subscription).permit(:additional_info, :url, :renewal_date, :reminder_delay_days, :image_url)
  end

  def set_subscriptions
    @subscription = Subscription.find(params[:id])
  end
end
