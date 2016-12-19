class DemoNights::ProjectsController < ApplicationController
  def index
    @demo_night = DemoNight.find(params[:demo_night_id])
    @projects = @demo_night.projects
  end
end
