class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
   @user = User.find(params[:id])
  end

   def new
     @user = User.new
   end

  # def create
  #   @user = User.create!(user_params)
  #   if @user.valid?
  #     session[:user_id] = @user.id
  #     redirect_to @user
  #   end
  # end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_path(@user)
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :gender, :first_name, :last_name, :phone_number, :address)
  end
end
