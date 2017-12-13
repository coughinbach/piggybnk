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
    # @project = current_user.projects.build(project_params)
    authorize @project
    @project.goal_amount_total =  @project.goal_amount_total * 100
    if @project.save
      total_participants_count = user_ids.count + 1
      # solo goal is always total goal / number of participants
      @goal_amount_solo = @project.goal_amount_total_cents / total_participants_count
      # calculate withdrawal amount with solo and total saved at 0
      withdrawal = (@goal_amount_solo / (@project.due_date - Date.today))
      # create admin UserProject
      @userproject = UserProject.create(user: current_user, project: @project, project_admin: true, goal_amount_solo_cents: @goal_amount_solo, withdrawal_amount_total_cents: withdrawal)
      # create UserProject for each user_id present in user_ids

      user_ids.each do |user_id|
        UserProject.create(user_id: user_id, project: @project, goal_amount_solo_cents: @goal_amount_solo, withdrawal_amount_total_cents: withdrawal)
      end
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
    @userproject = @project.user_projects.where(user: current_user).first
    authorize @project
    if @project.update(project_params)
      # total_saved is equal to sum of solo_saved of all participants
      all_piggies = []
      @project.user_projects.each { |u_p| all_piggies << u_p.saved_amount_solo_cents }
      # update total saved after withdrawal or injection
      @project.update(saved_amount_total_cents: all_piggies.inject(:+))
      # solo goal is always total goal / number of participants
      @goal_amount_solo = @project.goal_amount_total_cents / (@project.user_projects.count)
      # update solo goal for current user (after injection, withdrawal, or change of total goal)
      @userproject.update(goal_amount_solo_cents: @goal_amount_solo)
      # update solo goal for other users (after injection, withdrawal, or change of total goal)
      # @project.user_projects.each { |user_project| user_project.update(goal_amount_solo_cents: goal_amount_solo_cents) }
      # calculate withdrawal amount (after withdrawal, injection, or change of total goal/due date)
      # update withdrawal for all users (after withdrawal, injection, or change of total goal/due date)
      @project.user_projects.each do |user_project|
        user_project.update(goal_amount_solo_cents: @goal_amount_solo)
        withdrawal = (user_project.goal_amount_solo_cents - user_project.saved_amount_solo_cents) / (@project.due_date - Date.today)
        user_project.update(withdrawal_amount_total_cents: withdrawal)
      end
      # withdrawal = (@userproject.goal_amount_solo_cents - @userproject.saved_amount_solo_cents) / (@project.due_date - Date.today)
      #
      #  @project.user_projects.each { |user_project| user_project.update(withdrawal_amount_total_cents: withdrawal)}
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    authorize @project
    @project.delete
    redirect_to dashboard_path
  end

  def breakbnk
    @project = Project.find(params[:id])
    authorize @project
    @project.update(status: "Completed")
    redirect_to project_path(@project)
  end

  private

  def user_ids
    ids = []
    params[:project][:user_ids].each do |user_id|
      user_id = user_id.to_i
      # "".to_i is 0, go to next line in the case of solo project
      next if user_id == 0
      ids << user_id
    end
    return ids
  end

  def set_project
    @project = Project.find(params[:id])
    authorize @project
  end

  def project_params
    params.require(:project).permit(:name, :description, :due_date, :goal_amount_total_cents, :category_id)
  end

end
