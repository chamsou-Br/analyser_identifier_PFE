# frozen_string_literal: true

class AddCostToAct < ActiveRecord::Migration[4.2]
  def change
    add_column :acts, :cost, :string, limit: 765
  end
end
