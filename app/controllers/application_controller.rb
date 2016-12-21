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
    DemoNight.current.status == "accepting_submissions" && Project.find(project_id).user_id == current_user.id
  end
end
