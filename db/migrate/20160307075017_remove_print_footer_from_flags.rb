class RemovePrintFooterFromFlags < ActiveRecord::Migration[4.2]
  def change
    remove_column :flags, :print_footer
  end
end
