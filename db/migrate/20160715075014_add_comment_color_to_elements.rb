class AddCommentColorToElements < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :comment_color, :string, :default => "#6F78B9"
  end
end
