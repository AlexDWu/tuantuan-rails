# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @runs = Order.where(user: @user)
  end
end
