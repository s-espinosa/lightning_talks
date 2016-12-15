class SessionsController < ApplicationController
  skip_before_action :authorize_user

  def new
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    flash[:success] = "Signed in!"
    redirect_to root_redirect
  end
end
