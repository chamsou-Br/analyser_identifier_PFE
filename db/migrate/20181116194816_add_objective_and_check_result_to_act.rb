# frozen_string_literal: true

class AddObjectiveAndCheckResultToAct < ActiveRecord::Migration[4.2]
  def change
    add_column :acts, :objective, :text
    add_column :acts, :check_result, :text
  end
end
