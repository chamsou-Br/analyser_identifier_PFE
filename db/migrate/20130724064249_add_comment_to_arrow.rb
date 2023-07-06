class AddCommentToArrow < ActiveRecord::Migration[4.2]
  def change
    add_column :arrows, :comment, :text
  end
end
