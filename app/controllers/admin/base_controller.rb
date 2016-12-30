class Admin::BaseController < ApplicationController
  before_action :authorize_admin

  def authorize_admin
    raise ActionController::RoutingError.new('Not Found') unless current_user.admin?
  end
end
