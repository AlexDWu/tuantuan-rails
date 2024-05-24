# frozen_string_literal: true

class RunsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @runs = Run.where(user: @user)
  end

  def show
    @run = Run.find(params[:id])
    raise ActionController::RoutingError, 'Not Found' if @run.user != current_user
  end

  def new
    @run = Run.new
  end

  def create
    # @run = Run.new(name: '...', close_time: 1.week.from_now, user: current_user, status: 'draft')
    @run = Run.new(run_params.merge(user: current_user, status: 'draft'))

    if @run.save
      redirect_to @run
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @run = Run.find(params[:id])
    raise ActionController::RoutingError, 'Not Found' if @run.user != current_user
  end

  def update
    @run = Run.find(params[:id])
    raise ActionController::RoutingError, 'Not Found' if @run.user != current_user

    if @run.update(run_params)
      redirect_to @run
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @run = Run.find(params[:id])
    raise ActionController::RoutingError, 'Not Found' if @run.user != current_user

    @run.destroy
    redirect_to runs_path, status: :see_other
  end

  private

  def run_params
    params.require(:run).permit(:name, :close_time)
  end
end
