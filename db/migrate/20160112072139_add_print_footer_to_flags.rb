class AddPrintFooterToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :print_footer, :boolean, :default => false
  end
end
