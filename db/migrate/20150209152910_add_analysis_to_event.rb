class AddAnalysisToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :analysis, :string, limit: 765
  end
end
