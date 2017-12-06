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
      formula = (@project.goal_amount_total_cents / (@project.due_date - Date.today))
      @userproject = UserProject.create(user: current_user, project: @project, project_admin: true, goal_amount_solo_cents: @project.goal_amount_total_cents, withdrawal_amount_total_cents: formula)
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
    @userproject = @project.user_projects.where(user: current_user).first

    # iterate through all @project.user_projects.saved_amount_solo_cents for each collaborator and add all values to collective piggy bank
    # @allpiggies = @project.saved_amount_total_cents
    # @project.user_projects.each { |u_p| @allpiggies += u_p.saved_amount_solo_cents }

    if @project.update(project_params)
      @userproject.update(goal_amount_solo_cents: @project.goal_amount_total_cents)
      formula = (@userproject.goal_amount_solo_cents - @userproject.saved_amount_solo_cents) / (@project.due_date - Date.today)
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
