# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :run

  has_many :items, through: :run

  has_many :item_orders, dependent: :destroy
  accepts_nested_attributes_for :item_orders
end
