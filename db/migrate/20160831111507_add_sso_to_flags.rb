class AddSsoToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :sso, :boolean, :default => false
    Flag.update_all( sso: false )
  end
end
