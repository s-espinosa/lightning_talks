class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize_user
  helper_method :current_user
  helper_method :owner_and_accepting

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize_user
    redirect_to login_path unless current_user
  end

  def owner_and_accepting(project_id)
    project = Project.find(project_id)
    current_dn = DemoNight.current
    current_dn.status == "accepting_submissions" && project.demo_night_id == current_dn.id && project.user_id == current_user.id
  end
end
