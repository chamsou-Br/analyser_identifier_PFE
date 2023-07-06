class AddRacToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :rac, :boolean, :default => false
    Flag.update_all( rac: false )
  end
end
