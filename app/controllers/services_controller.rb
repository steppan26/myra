class ServicesController < ApplicationController

  after_action :authorize_service, only: [:show]

  def index
    @services = Service.all
  end

  def show
    @service = Service.find(params[:id])
  end

  private

  def authorize_service
    authorize @service
  end
end
