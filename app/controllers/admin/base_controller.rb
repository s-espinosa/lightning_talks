class Admin::BaseController < ApplicationController
  before_action :authorize_admin

  def authorize_admin
    redirect_to errors_404_path unless current_user.admin?
  end
end
