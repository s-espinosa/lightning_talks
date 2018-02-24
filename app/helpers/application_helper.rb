module ApplicationHelper

  def current_lightning_talk?
    LightningTalk.current != nil
  end

  def accepting_submissions?
    LightningTalk.current != nil && LightningTalk.current.accepting_submissions?
  end

  def voting?
    LightningTalk.current != nil && LightningTalk.current.voting?
  end
end
