class Admin::DashboardController < Admin::BaseController

  def show
    @projects = Project.all
  end
end
