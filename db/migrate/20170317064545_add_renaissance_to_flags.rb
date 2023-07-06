class AddRenaissanceToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :renaissance, :boolean, :default => false
  end
end
