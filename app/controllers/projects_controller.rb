class ProjectsController < ApplicationController

  def index
    @userprojects = UserProject.where(user: current_user)
    @projects = @userprojects.map { |u_p| u_p.project }
  end

  def show
    @project = Project.find(params[:id])
    @userproject = @project.user_projects.where(user: current_user).first
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      formula = (@project.goal_amount_total_cents / (@project.due_date - Date.today)) #add goal - current / days
      @userproject = UserProject.create(user: current_user, project: @project, project_admin: true, withdrawal_amount_total_cents: formula)
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      formula = (@project.goal_amount_total_cents / (@project.due_date - Date.today)) #add goal - current / days
      @project.user_projects.first.update(withdrawal_amount_total_cents: formula)
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.delete
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :due_date, :goal_amount_total_cents)
  end

end
