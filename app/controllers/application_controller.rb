class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    if not session[:user_id].nil?
      then return User.find_by user_id:session[:user_id]
    else return nil
    end
  end

end
