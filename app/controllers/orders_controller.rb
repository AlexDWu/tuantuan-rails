# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user

    if params[:run_id]
      # this is for merchants to see the orders for their run
      @run = Run.find_by(id: params[:run_id], user: current_user)
      @items = @run.items.order(id: :asc)
      @orders = @run.orders.includes(:item_orders)
      render('run_orders')
    else
      @orders = Order.where(user: @user).includes(run: { items: { images_attachments: :blob } })
    end
  end

  def edit
    @order = Order.find(params[:id])
    raise ActionController::RoutingError, 'Not Found' if @order.user != current_user
  end

  def create
    @order = Order.create!(order_params.merge(user: current_user))
    flash[:notice] = 'Order Sucessfully Created'
    redirect_to edit_order_path @order
  end

  def update
    @order = current_user.orders.find(params[:id])
    @order.update!(order_params)
    flash[:notice] = 'Order Sucessfully Updated'
    redirect_to edit_order_path @order
  end

  private

  def order_params
    params.require(:order).permit(:run_id, item_orders_attributes: %i[id quantity item_id])
  end
end
