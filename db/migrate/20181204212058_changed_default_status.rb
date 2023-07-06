# frozen_string_literal: true

class ChangedDefaultStatus < ActiveRecord::Migration[4.2]
  def up
    change_column_default(:events, :state, nil)
    change_column_default(:acts, :state, nil)
  end

  def down
    change_column_default(:events, :state, 0)
    change_column_default(:acts, :state, 0)
  end
end
