# frozen_string_literal: true

class CreateRuns < ActiveRecord::Migration[7.1]
  def change
    create_table :runs do |t|
      t.string :name
      t.datetime :close_time
      t.string :status
      t.belongs_to :user

      t.timestamps
    end
    add_foreign_key :runs, :users
  end
end
