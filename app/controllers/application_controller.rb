class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  # Authentication compatibility methods
  def logged_in?
    user_signed_in?
  end

  def authenticated?
    user_signed_in?
  end

  helper_method :logged_in?, :authenticated?

  def current_site
    Site.current
  end
  helper_method :current_site

  def space
    nil
  end
  helper_method :space
end
