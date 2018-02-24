class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize_user
  helper_method :current_user
  helper_method :owner_and_accepting
  helper_method :current_admin?

  force_ssl if Rails.env.production?

  private

  def current_admin?
    current_user && current_user.admin?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize_user
    redirect_to login_path unless current_user
  end

  def root_redirect
    if current_user.admin?
      admin_lightning_talks_path
    elsif LightningTalk.current && LightningTalk.current.accepting_submissions?
      new_project_path
    elsif LightningTalk.current && LightningTalk.current.voting?
      projects_path
    else
      no_lightning_talk_path
    end
  end

  def owner_and_accepting(project_id)
    project = Project.find(project_id)
    current_dn = LightningTalk.current
    current_dn.status == "accepting_submissions" && project.lightning_talk_id == current_dn.id && project.user_id == current_user.id
  end
end
