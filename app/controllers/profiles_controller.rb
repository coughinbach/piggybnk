class ProfilesController < ApplicationController
  skip_after_action :verify_authorized

  def show
    @user = current_user
  end

  def edit
  end
end
