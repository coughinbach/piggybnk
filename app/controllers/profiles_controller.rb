class ProfilesController < ApplicationController
  skip_after_action :verify_authorized

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:credit_card, :photo)
  end
end
