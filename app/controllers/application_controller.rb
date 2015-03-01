class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
  end
  helper_method :current_user

  def disable_nav
    @disable_nav = true
  end
end
