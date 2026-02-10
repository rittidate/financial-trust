class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :authenticate_user!

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authenticate_user!
    redirect_to new_session_path, alert: "Please login first" unless current_user
  end
end
