# frozen_string_literal: true

class AddCheckedAtToNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :checked_at, :datetime
  end
end
