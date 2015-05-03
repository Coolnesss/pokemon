class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :get_id

  def current_user
    return nil unless session[:user_id]
    User.find_by_id session[:user_id]
  end

  def get_id name
    JSON.parse(Pokegem.get("pokemon", name.downcase))['national_id']
  end
end
