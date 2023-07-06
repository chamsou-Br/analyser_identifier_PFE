class AddAttachmentToArrow < ActiveRecord::Migration[4.2]
  def up
    add_column :arrows, :attachment, :string
    Arrow.update_all(:attachment => 'none')
  end

  def down
  	remove_column :arrows, :attachment
  end
end
