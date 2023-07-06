# frozen_string_literal: true

class ChangeCriticalityToCriticalityIdInEvents < ActiveRecord::Migration[4.2]
  def change
    rename_column :events, :criticality, :criticality_id
  end
end
