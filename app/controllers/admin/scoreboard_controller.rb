class Admin::ScoreboardController < Admin::BaseController
  def show
    @lightning_talk = LightningTalk.current
    if @lightning_talk.nil?
      flash[:warning] = "There is no active demo night."
      redirect_to admin_lightning_talks_path
    end
  end
end
