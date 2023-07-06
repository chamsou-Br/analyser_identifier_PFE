class AddCommentIndexIntToGraph < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs, :comment_index_int, :boolean, :default => true
  end
end
