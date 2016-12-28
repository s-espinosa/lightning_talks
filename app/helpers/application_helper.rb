module ApplicationHelper
  def accepting_submissions?
    DemoNight.current != nil && DemoNight.current.accepting_submissions?
  end

  def current_demo_night?
    DemoNight.current != nil
  end
end
