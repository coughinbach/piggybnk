class UserProjectsController < ApplicationController
  skip_after_action :verify_authorized
  def update
    @userproject = UserProject.find(params[:id])
    @project = @userproject.project
    if @userproject.update(userproject_params)
      @userproject.saved_amount_solo_cents = @userproject.saved_amount_solo_cents + @userproject.extra_withdrawal_cents*100
      @userproject.update(saved_amount_solo_cents: @userproject.saved_amount_solo_cents)
      @project.saved_amount_total_cents = @project.saved_amount_total_cents + @userproject.extra_withdrawal_cents*100
      @project.update(saved_amount_total_cents: @project.saved_amount_total_cents)
      flash[:notice] = "Oink Oink!"
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  private

  def userproject_params
    params.require(:user_project).permit(:extra_withdrawal_cents)
  end

end
