# frozen_string_literal: true

class RemoveSourceFromEvents < ActiveRecord::Migration[4.2]
  def change
    remove_column :events, :source, :string
  end
end
