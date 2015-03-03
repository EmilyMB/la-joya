class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def disable_nav
    @disable_nav = true
  end

  def authorize!
    flash[:error] = "Favor de darle clic en Entrar para seguir"
    redirect_to root_path unless current_user
  end
end
