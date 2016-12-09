class Admin::DemoNightsController < Admin::BaseController
  def new
    @demo_night = DemoNight.new
  end
end
