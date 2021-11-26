class SubscriptionsController < ApplicationController
  before_action :set_subscriptions, only: %i[show edit update destroy]
  after_action :authorize_subscription, only: %i[show new create edit update destroy active? active! desactive!]

  def index
    @subscriptions = Subscription.all
    user_subscriptions = Subscription.where(user_id: current_user)
    @user_monthly_spend = Money.new(user_subscriptions.sum(:price_per_day_cents) * 30)
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

  def new
    @subscription = Subscription.new
    @categories = Category.all
    @category = Category.all.map { |category| category.name }

    if params[:query].present?
      @services = Service.where("name ILIKE ?" "%#{params[:query]}%")
    else
      @services = Service.all
    end
    authorize @subscription
  end

  def create
    authorize :subscription

    raise
    redirect_to dashboard_path
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

  def active?
    @is_active
  end

  def activate!
    @is_active = true
  end

  def deactivate!
    @is_active = false
    render partial: 'display_services', locals: { services: @services }
  end

  def display_services
    query = params[:query]
    @services = query.downcase == 'none' ? Service.all : Category.find(query).services.uniq
    authorize :subscription
    render partial: 'services/services_list', locals: { services: @services }
  end

  def display_offers
    @service = Service.find(params[:query])
    @offers = @service.offers
    authorize :subscription
    render partial: 'offers/offers_list', locals: { offers: @offers }
  end

  def display_offer_form
    authorize :subscription
    @offer = Offer.new
    render partial: 'offers/custom_offer', locals: { offer: @offer }
  end

  def subscription_overview
    authorize :subscription

    @offer = Offer.new(
      service_id: params[:serviceId],
      name: params[:name],
      category_id: params[:categoryId],
      price_cents: (params[:price].to_f * 100).to_i,
      frequency: params[:frequency]
    )
    @offer.user = current_user if current_user

    render partial: 'subscriptions/new_subscription', locals: { offer: @offer }
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
