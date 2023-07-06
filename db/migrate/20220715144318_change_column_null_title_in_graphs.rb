class ChangeColumnNullTitleInGraphs < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:graphs, :title, false)
  end
end
