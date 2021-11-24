class SubscriptionsController < ApplicationController
  before_action :set_subscriptions, only: %i[show edit update destroy]
  after_action :authorize_subscription, only: [:show, :new, :create, :edit, :update, :destroy]

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
    authorize @subscription
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

  def display_services
    @services = Category.where(name: params[:query]).first.services.uniq
    authorize :subscription
    render partial: 'display_services', locals: { services: @services }
  end

  def display_offers
    p params[:query]
    @service = Service.where(name: params[:query]).first
    @offers = @service.offers
    authorize :subscription
    render partial: 'display_offers', locals: { offers: @offers }
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
