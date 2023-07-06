class AddTitleToEvaluationSystem < ActiveRecord::Migration[5.1]
  def change
    add_column :evaluation_systems, :title, :string, limit: 765
  end
end
