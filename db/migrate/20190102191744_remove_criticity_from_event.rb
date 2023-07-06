# frozen_string_literal: true

class RemoveCriticityFromEvent < ActiveRecord::Migration[4.2]
  def change
    remove_column :events, :criticity, :integer
  end
end
