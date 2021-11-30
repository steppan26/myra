class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  after_action :authorize_user, only: [:edit, :update]

  def edit
  end

  def update
    @user.global_budget_cents = params[:user]["global_budget"] * 100
    @user.update(user_params)
    redirect_to "/settings"
  end

  private

  def user_params
    params.require(:user).permit(:global_budget)
  end

  def set_user
    @user = current_user
  end

  def authorize_user
    authorize @user
  end
end
