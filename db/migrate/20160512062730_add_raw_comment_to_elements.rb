class AddRawCommentToElements < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :raw_comment, :text, :limit => 16777215 # MEDIUMTEXT
  end
end
