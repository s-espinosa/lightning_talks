class ProjectsController < ApplicationController

  def new
    if LightningTalk.current
      @project = LightningTalk.current.projects.new
      @modules = ["BE Mod 2", "BE Mod 3", "BE Mod 4", "FE Mod 2", "FE Mod 3", "FE Mod 4", "Posse"]
    else
      flash[:error] = "There is no active lightning talk yet. BRB."
      redirect_to root_path
    end
  end

  def create
    @project = LightningTalk.current.projects.new(project_params)
    if @project.save
      flash[:success] = "Project successfully submitted!"
      redirect_to projects_path
    else
      flash[:error] = "There was an issue creating this project"
      redirect_to new_project_path
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def index
    @projects = LightningTalk.current.projects
  end

  def edit
    @project = Project.find(params[:id])
    @modules = ["BE Mod 2", "BE Mod 3", "BE Mod 4", "FE Mod 2", "FE Mod 3", "FE Mod 4", "Posse"]
  end

  def update
    project = Project.find(params[:id])
    if project.update(project_params)
      redirect_to projects_path
    else
      flash[:danger] = "Something went wrong!"
      redirect_to edit_project_path(project)
    end
  end

  private

  def project_params
    params.require(:project).permit(:group_members, :name, :project_type, :final_confirmation, :lightning_talk_id, :note).merge(user_id: current_user.id)
  end
end
