module ApplicationHelper

  def current_demo_night?
    DemoNight.current != nil
  end

  def accepting_submissions?
    DemoNight.current != nil && DemoNight.current.accepting_submissions?
  end

  def voting?
    DemoNight.current != nil && DemoNight.current.voting?
  end
end
