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
    @subscription = Subscription.new
    authorize :subscription
    price_cents = (params[:subscription][:offers][:price_cents]).to_i * 100
    custom_offer = params[:subscription][:offer_id].to_i == -1

    if custom_offer
      offer = Offer.create(
        name: "custom offer",
        service_name: params[:subscription][:offers][:service_name],
        price_cents: price_cents,
        frequency: params[:subscription][:offers][:frequency],
        category_id: params[:subscription][:offers][:category_id],
      )
      offer.user = current_user
    else
      offer_id = params[:subscription][:offer_id]
      offer = Offer.find(offer_id)
    end
    renewal_date = Date.parse(params[:subscription][:renewal_date])
    custom_img_url = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.shareicon.net%2Fdata%2F2017%2F07%2F13%2F888376_office_512x512.png&f=1&nofb=1"
    new_subscription = Subscription.new(
      offer: offer,
      user_id: current_user.id,
      additional_info: params[:subscription][:additional_info],
      price_per_day_cents: get_price_per_day_cents(price_cents, params[:subscription][:offers][:frequency]),
      renewal_date: renewal_date,
      reminder_delay_days: params[:subscription][:reminder_delay_days],
      url: custom_offer ? "www.google.com" : offer.service.url,
      image_url: custom_offer ? custom_img_url : offer.service.image_url
    )
    if new_subscription.save
      redirect_to dashboard_path
    else
      puts 'there was a problem creating the subscription'
    end
  end

  def update
    authorize @subscription
    subscription = Subscription.find(params[:id])
    subscription.update(subscription_params)
    redirect_to subscription_path(subscription)
  end

  def destroy
    @subscription.destroy
    redirect_to "/dashboard"
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
    if params[:offerId] == "-1"
      @offer = Offer.new(
        name: params[:name],
        category_id: params[:categoryId],
        price_cents: (params[:price].to_f * 100).to_i,
        frequency: params[:frequency],
        service_name: params[:serviceName]
      )
      @service = nil
    else
      @offer = Offer.find(params[:offerId])
      @service = @offer.service
    end

    @offer.user = current_user if current_user
    render partial: 'subscriptions/new_subscription', locals: { offer: @offer, service: @service }
  end

  private

  def get_price_per_day_cents(value, frequency)
    case frequency
    when 'annualy'
      return (value / 365).round.to_i
    when 'monthly'
      return (value / 30).round.to_i
    else
      return (value / 7).round.to_i
    end
  end

  def subscription_params
    params.require(:subscription).permit(:additional_info, :url, :renewal_date, :reminder_delay_days, :image_url, :photo)
  end

  def set_subscriptions
    @subscription = Subscription.find(params[:id])
  end

  def authorize_subscription
    authorize @subscription
  end
end
