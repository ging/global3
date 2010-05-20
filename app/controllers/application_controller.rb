class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  def logged_in?
    false
  end
end
