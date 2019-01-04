class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    else
      User.new
    end
  end

  def logged_in?
    !!current_user.id
  end

  def authorized?
    if !logged_in?
      flash[:authorized] = "You aren't logged in!"
      redirect_to login_path and return
      false
    else
      true
    end
  end

  def authorized_for(user_id)
    if current_user.id != user_id.to_i && current_user.admin != true
      flash[:authorized] = "Access Denied!"
      redirect_to current_user
    end
  end
end
