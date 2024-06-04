# frozen_string_literal: true

class HashController < ApplicationController
  before_action :authenticate_user!
  def show
    @run = Run.from_sqid(params[:hash_id])
    @order = Order.find_by(user: current_user, run: @run)
    return if @order

    @order = Order.build(user: current_user, run: @run, item_orders: @run.items.map do |item|
      ItemOrder.build(item_id: item.id, quantity: 0)
    end)
  end
end
