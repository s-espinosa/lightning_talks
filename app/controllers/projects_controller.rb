class ProjectsController < ApplicationController

  def new
    if DemoNight.current
      @project = Project.new
      @current = DemoNight.current.id
      @modules = ["BE Mod 2", "BE Mod 3", "BE Mod 4", "FE Mod 2", "FE Mod 3", "FE Mod 4", "Posse"]
    else
      flash[:error] = "There is no active demo night, please ask Sal to make one"
      redirect_to root_path
    end
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = "Project successfully submitted!"
      redirect_to project_path(@project)
    else
      flash[:error] = "There was an issue creating this project"
      redirect_to new_project_path
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def index
    @projects = Project.where.not(id: current_user.projects)
  end

  private

  def project_params
    params.require(:project).permit(:group_members, :name, :project_type, :final_confirmation, :demo_night_id)
  end
end
