class OffersController < ApplicationController
  before_action :set_offers, only: [:edit, :update]
  before_action :authorize, only: [:create, :update, :destroy, :new, :edit]

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = current_user
    @offer.save!
    authorize @offer
  end

  def edit
    authorize @offer
  end

  def update
    @offer.update(offer_params)
    authorize @offer
  end

  def destroy
    @offer.destroy
    authorize @offer
    redirect_to "/subscriptions"
  end

  private

  def set_offers
    @offer = Offer.find()
  end

  def offer_params
    params.require(:offer).permit(:name, :price_cents, :frequency, :category)
  end

  def authorize
    authorize @offer
  end
end
