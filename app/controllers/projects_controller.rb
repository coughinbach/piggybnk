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
      total_participants_count = user_ids.count + 1
      goal_amount_solo_cents = @project.goal_amount_total_cents / total_participants_count
      formula = (goal_amount_solo_cents / (@project.due_date - Date.today))
      @userproject = UserProject.create(user: current_user, project: @project, project_admin: true, goal_amount_solo_cents: goal_amount_solo_cents, withdrawal_amount_total_cents: formula)
      user_ids.each do |user_id|
        UserProject.create(user_id: user_id, project: @project, goal_amount_solo_cents: goal_amount_solo_cents, withdrawal_amount_total_cents: formula)
      end
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
    # allpiggies = 0
    # @project.user_projects.each do |user_project|
    #   allpiggies += user_project.saved_amount_solo_cents
    #   allpiggies
    # end

    #DO TOTALS: solo + group change after withdrawal, boost

    if @project.update(project_params)
      # @project.update(saved_amount_total_cents: allpiggies)
      total_participants_count = @project.user_projects.count
      goal_amount_solo_cents = @project.goal_amount_total_cents / total_participants_count
      @userproject.update(goal_amount_solo_cents: goal_amount_solo_cents)
      formula = (goal_amount_solo_cents - @userproject.saved_amount_solo_cents) / (@project.due_date - Date.today)
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

  def user_ids
    ids = []

    params[:project][:user_ids].each do |user_id|
      user_id = user_id.to_i
      next if user_id == 0

      ids << user_id
    end

    return ids
  end

  def project_params
    params.require(:project).permit(:name, :description, :due_date, :goal_amount_total_cents)
  end

end
