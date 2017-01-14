class Admin::ScoreboardController < Admin::BaseController
  def show
    @demo_night = DemoNight.current
  end
end
