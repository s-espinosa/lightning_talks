class Admin::DashboardController < Admin::BaseController

  def show
    @demo_night = DemoNight.current
  end
end
