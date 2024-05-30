# frozen_string_literal: true

class HashController < ApplicationController
  before_action :authenticate_user!
  def show
    @run = Run.from_sqid(params[:hash_id])
  end
end
