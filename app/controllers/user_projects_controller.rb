class UserProjectsController < ApplicationController
  skip_after_action :verify_authorized
  def update
    @userproject = UserProject.find(params[:id])
    @project = @userproject.project
    if @userproject.update(userproject_params)
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
