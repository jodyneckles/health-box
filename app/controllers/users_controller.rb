class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    authorized_for(params[:id])
    @user = User.find(params[:id])
  end

   def new
     @user = User.new
   end


  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), :notice => "Your logged in as #{@user.username}"
    else
      render :new
    end
  end

  def edit
    authorized_for(params[:id])
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to @user, :notice => "Your Account was updated successfully"
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to login_path, :notice => "Your user has been deleted"
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :gender, :first_name, :last_name, :phone_number, :address)
  end
end
