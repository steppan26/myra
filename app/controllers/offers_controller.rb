class OffersController < ApplicationController
  before_action :set_offers, only: [:edit, :update]
  after_action :authorize_offer, only: [:new, :create, :edit, :update, :destroy]

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = current_user
    @offer.save!
  end

  def edit
  end

  def update
    @offer.update(offer_params)
  end

  def destroy
    @offer.destroy
    redirect_to "/subscriptions"
  end

  private

  def set_offers
    @offer = Offer.find()
  end

  def offer_params
    params.require(:offer).permit(:name, :price_cents, :frequency, :category)
  end

  def authorize_offer
    authorize @offer
  end
end
