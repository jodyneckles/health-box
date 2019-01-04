class OrdersController < ApplicationController

  def create
    @order= Order.create(order_params)
    @user = @order.user
    @orders = Order.where(user_id: params[:order][:user_id]).reverse.take(5) 
    render 'users/show'
  end

  private

  def order_params
    params.require(:order).permit(:recipe_id, :user_id)
  end

end
