# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @orders = Order.where(user: @user)
  end

  def create
    @order = Order.create!(order_params.merge(user: current_user))
  end

  def update
    @order = current_user.orders.find(params[:id])
    @order.update!(order_params)
  end

  private

  def order_params
    params.require(:order).permit(:run_id, item_orders_attributes: %i[id quantity item_id])
  end
end
