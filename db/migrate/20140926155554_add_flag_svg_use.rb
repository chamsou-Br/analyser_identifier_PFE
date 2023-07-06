class AddFlagSvgUse < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :svg_use, :boolean, :default => false
    Flag.update_all( :svg_use => false )
  end
end
