# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :run

  has_many_attached :images, dependent: :destroy do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100], preprocessed: true
    attachable.variant :standard, resize_to_limit: [256, 256], preprocessed: true
  end
end
