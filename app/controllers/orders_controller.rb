# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @orders = Order.where(user: @user)
  end

  def update
    @order = current_user.orders.find(params[:id])
    @order.update!(order_params)
  end

  private

  def order_params
    params.require(:order).permit(item_orders_attributes: %i[id quantity])
  end
end
