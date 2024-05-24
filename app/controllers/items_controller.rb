# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    @run = Run.find(params[:run_id])
    raise ActionController::RoutingError, 'Not Found' if @run.user != current_user

    @item = @run.items.create(item_params)
    redirect_to run_path(@run)
  end

  def destroy
    @run = Run.find(params[:run_id])
    raise ActionController::RoutingError, 'Not Found' if @run.user != current_user

    @item = @run.items.find(params[:id])
    @item.destroy
    redirect_to run_path(@run), status: :see_other
  end

  private

  def item_params
    params.require(:item).permit(:name, :max_quantity, images: [])
  end
end
