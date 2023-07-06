class AddRawCommentToArrows < ActiveRecord::Migration[4.2]
  def change
    add_column :arrows, :raw_comment, :text, :limit => 16777215 # MEDIUMTEXT
  end
end
