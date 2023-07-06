class AddIndicatorCommentOnElements < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :indicator_comment, :text
  end
end
