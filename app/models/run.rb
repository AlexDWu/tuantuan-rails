# frozen_string_literal: true

class Run < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :close_time, presence: true

  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy
  belongs_to :user

  def self.from_sqid(sqid)
    find(Sqids.new.decode(sqid)[0])
  end

  def sqid
    Sqids.new.encode([id])
  end
end
