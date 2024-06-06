# frozen_string_literal: true

class ItemOrdersController < ApplicationController
  before_action :authenticate_user!
end
