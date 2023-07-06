class AddCommentToElement < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :comment, :text
  end
end
