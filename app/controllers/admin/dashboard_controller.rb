class Admin::DashboardController < Admin::BaseController

  def show
    @lightning_talk = LightningTalk.current
  end
end
