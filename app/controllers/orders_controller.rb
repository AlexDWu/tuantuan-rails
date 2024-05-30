# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @orders = Order.where(user: @user)
  end

  def create
    @run = Run.find(params[:run_id])
    puts("run id: #{params}")
  end
end
