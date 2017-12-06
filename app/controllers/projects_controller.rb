class ProjectsController < ApplicationController

  def index
    @userprojects = policy_scope(UserProject)
    @projects = @userprojects.map { |u_p| u_p.project }
  end

  def show
    @project = Project.find(params[:id])
    @userproject = @project.user_projects.where(user: current_user).first
    authorize @project
  end

  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    @project = current_user.projects.build(project_params)
    authorize @project
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
    authorize @project
  end

  def update
    @project = Project.find(params[:id])
    authorize @project
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
    authorize @project
    @project.delete
    redirect_to projects_path
  end

  private

  def set_project
    @project = Project.find(params[:id])
    authorize @project
  end

  def project_params
    params.require(:project).permit(:name, :description, :due_date, :goal_amount_total_cents)
  end

end
