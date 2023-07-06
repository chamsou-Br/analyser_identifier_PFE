# frozen_string_literal: true

class AddSubmittedAtToEvaluation < ActiveRecord::Migration[5.1]
  def change
    add_column :evaluations, :submitted_at, :datetime
  end
end
