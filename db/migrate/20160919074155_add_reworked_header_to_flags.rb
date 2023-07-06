class AddReworkedHeaderToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :reworked_header, :boolean, :default => false
    Flag.update_all reworked_header: false
  end
end
