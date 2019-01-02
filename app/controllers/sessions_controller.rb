class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user
    else
      flash[:errors] = ["Incorrect username or password"]
      redirect_to login_path
    end
  end

  # def create
  #   @user = User.find_by(username: params[:username])
  #   return head(:forbidden) unless @user.authenticate(params[:password])
  #   session[:user_id] = @user.id
  # end
end
