# frozen_string_literal: true

class Run < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :close_time, presence: true

  has_many :items, dependent: :destroy
  belongs_to :user
end
