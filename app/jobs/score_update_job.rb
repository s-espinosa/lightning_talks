class ScoreUpdateJob < ApplicationJob
  queue_as :default

  def perform(top_five)
    ActionCable.server.broadcast 'scoreboard_channel', message: render_projects(top_five)
  end

  private

  def render_projects(projects)
    ApplicationController.renderer.render(partial: '/admin/scoreboard/projects', locals: { projects: projects })
  end
end
