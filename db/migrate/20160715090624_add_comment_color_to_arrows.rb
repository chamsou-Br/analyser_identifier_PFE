class AddCommentColorToArrows < ActiveRecord::Migration[4.2]
  def change
    add_column :arrows, :comment_color, :string, :default => "#6F78B9"
  end
end
