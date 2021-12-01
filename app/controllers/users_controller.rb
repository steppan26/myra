class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  after_action :authorize_user, only: [:edit, :update]

  def edit
  end

  def update
    @user.update(user_params)
    respond_to do |format|
      format.html { redirect_to settings_path }
      format.text {
        if params[:user][:email]
          render partial: 'pages/settings_infos', locals: { user: current_user }, formats: [:html]
        else
          render partial: 'pages/settings_budget', locals: { user: current_user }, formats: [:html]
        end
      }
    end
  end

  private

  def user_params
    params.require(:user).permit(:global_budget, :email)
  end

  def set_user
    @user = current_user
  end

  def authorize_user
    authorize @user
  end
end
